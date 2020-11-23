//
//  YMTHomePageViewModel.swift
//  Yamoto
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class YMTHomePageViewModel: NSObject {

    let xxxdisposeBag = DisposeBag()
    
    let models = BehaviorRelay<[HomePage]>(value: [])

    //   let validatedUsername: Observable<ValidationResult>

    //最后结果集合
   //  let models =  Observable<[HomePage]>()

     //当前索引值
     var index : Int = 1
     
    
   // let dataList : Observable<Bool>
   //获取主页数据集合
    class  func loadHomePageDeta()-> Observable<[HomePage]>{
        return HomePageProvider.rx.request(.homePageData)
            .mapObject(YMTHomePage.self)
            .map{ ($0).result ?? []
                
            }
        .asObservable()
    }
           
    class func loadHomePageLocalDate() -> Observable<[HomePage]> {
        
        var dataList : Observable<[HomePage]>
      //  let itemes = "title":"1231" ,"content": "adfa","date":"adfa"
        let  result1 = [
                    "result" : [
                    
                        ["title": "第一条" ,"items": [["title":"sdfadf"]]],
                    
                    ["title": "第二条" ,"items": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]],
                    
                    ["title": "第三条" ,"items": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]]
                    ]
                    ]
        let aaa =  YMTHomePage(JSON: result1)
       dataList = Observable.just(aaa)
            //.mapObject(YMTHomePage.self)
            .map{
                ($0)?.result ?? []
        }
        return dataList
    }
    
  //  var disposeBagx = DisposeBag()


    
    class func loadHomePageListLocalDate(input :  Input) -> Output {
        

    var reStatus : Observable<RefreshStatus>
        
        reStatus = Observable.just(.none)
        
        let result1 = ["title": "第一组数据格式初始化" ,"array1":[],"array2": [
                                    ["title":"新产品","imageName":"menu_new"
                                        ,"imageUrl":[]],
                               ]] as [String : Any]
      
        var group1 : HomePage  = HomePage(JSON: result1)!
        
        
        let result2 = ["title": "第二条" ,"array1":[],"array2": [
                              ["title":"新产品","imageName":"menu_new"],
                              ["title":"爆款","imageName":"menu_hot"],
                              ["title":"购物","imageName":"menu_supermarket"],
                              ["title":"海鲜","imageName":"menu_seafood"],
                              ["title":"活动","imageName":"menu_activity"],
                              ["title":"折扣","imageName":"menu_discount"],
                              ["title":"旅行","imageName":"menu_travel"],
                              ["title":"拍卖","imageName":"menu_auction"],
                              ["title":"充值","imageName":"menu_pay"],
                              ["title":"分类","imageName":"menu_more"],
                         ]] as [String : Any]
                      
          let group2 : HomePage  = HomePage(JSON: result2)!
        
          let data : Observable<[HomePage]>  = HomePageProvider.rx.request(.homePageData)
            .mapObject(HomePage.self)
            .map{  group3 in
                
              //重组第一组数据
                var imageUrl: Array<String> = []
                for i in 0..<group3.array1!.count{
                    let  a = group3.array1?[i]
                    imageUrl.append((a?.url_big)!)
                   }
                group1.array2![0].imageUrl = imageUrl
                
              return [group1,group2,group3]
            }.asObservable()
        
        let outPut = Output(dataSource: data , refreshStatus :reStatus)
    
           return outPut
       }
}
    
    enum RefreshStatus {
          case none
          case beingHeaderRefresh
          case endHeaderRefresh
          case beingFooterRefresh
          case endFooterRefresh
          case noMoreData
    }
    

//
//
//    func transform(input: Input ) -> Output{
//
//
//              let  result1 = [
//                          "result" : [
//                          
//                              ["title": "第一条" ,"items": [["title":"sdfadf"]]],
//
//                          ["title": "第二条" ,"items": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]],
//
//                          ["title": "第三条" ,"items": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]]
//                          ]
//                          ]
//
//        let aaa =  YMTHomePage(JSON: result1)
//
//
//
//        return Output(dataSource: Observable.just(aaa)
//            //.mapObject(YMTHomePage.self)
//            .map{
//                ($0)?.result ?? []
//        })
//    }
//
//



extension YMTHomePageViewModel{
    
    struct Input {
        
        let category : HomePageApi
        var loadDateStatus :  RefreshStatus
    }
    
    
    struct Output {
        
        //返回控制器 数据集合
        let dataSource: Observable<[HomePage]>
       // let requestCommond = PublishSubject<Bool>()
        //告诉控制器当前刷新状态
        let refreshStatus : Observable<RefreshStatus>
        
    }
}
