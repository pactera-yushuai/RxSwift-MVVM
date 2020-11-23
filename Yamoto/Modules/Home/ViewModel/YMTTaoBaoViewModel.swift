//
//  OrderListViewModel.swift
//  Yamoto
//
//  Created by pactera on 2020/10/29.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import RxSwift

//enum RefreshStatus {
//         case none
//         case beingHeaderRefresh
//         case endHeaderRefresh
//         case beingFooterRefresh
//         case endFooterRefresh
//         case noMoreData
//   }

class YMTTaoBaoViewModel: NSObject {
    
   //获取主页数据集合
    class func loadLocalDate() -> Observable<[YMTTaoBaoModel]> {
        
        let  result1 = [
                    "array2" : [
                    ["title": "第一条" ,"imageUrl":["aaaa","aaaa"]],
                    ["title": "第二条" ,"imageUrl":["aaaa","aaaa"]],
                    ["title": "第三条" ,"imageUrl":["aaaa","aaaa"]],
                    ["title": "第四条" ,"imageUrl":["aaaa","aaaa"]],
                    ["title": "第五条" ,"imageUrl":["aaaa","aaaa"]],
                   ]]
                    
//                    ["title": "第三条" ,"items": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]]
                    
        
        let aaa =  YMTTaoBaoModel(JSON: result1)
        
        
        return  Observable.just(aaa)
            .map{ result in
                
                return [result!]
        }
    }
    
    
    //获取主页数据集合
     class func loadHeardDate() -> Observable<[YMTTaoBaoModel]> {
         
         let  result1 = [
                     "array2" : [
                     
                     ["title": "第一条" ,"items": [["title":"sdfadf"],["title":"sdfadf"]]],
                     ]]
         
         let aaa =  YMTTaoBaoModel(JSON: result1)
         return  Observable.just(aaa)
             .map{ result in
                     
                return [result!]
            }
     }

    
    var index : Int = 0
    
    //let models: Variable<[YMTTaoBaoModel]>


     func loadListLocalDate(input :  Input) -> Output {
        
       // var reStatus : Observable<RefreshStatus>

      //  reStatus = Observable.just(.none)
        
         let  result1 = ["array2" : [ ["title": "第一条" ,"imageUrl":["aaaa","aaaa"]],
                                                ["title": "第二条" ,"imageUrl":["aaaa","aaaa"]],
                                                ["title": "第三条" ,"imageUrl":["aaaa","aaaa"]],
                                                ["title": "第四条" ,"imageUrl":["aaaa","aaaa"]],
                                                ["title": "第五条" ,"imageUrl":["aaaa","aaaa"]],
                                               ]]
                            let aaa =  YMTTaoBaoModel(JSON: result1)
                            let dataSource1 : Observable<[YMTTaoBaoModel]>  =  Observable.just(([aaa!]))
        let outPut = Output(dataSource: dataSource1, refreshStatus: Observable.just(.none))
        
        
        outPut.requestCommond.subscribe(
            onNext :{
                  isReloadData in
                
                self.index = isReloadData ? 0 : self.index + 10
                
                
//                outPut.refreshStatus.map{ result in
//
//
//                    let state : RefreshStatus =    isReloadData ? RefreshStatus.endHeaderRefresh : RefreshStatus.endFooterRefresh
//
//                    print(result)
//
//                    print(state)
//                    return
//                }
//
                
           //    refreshStatus.
                
                
                
//                outPut.refreshStatus = isReloadData ? RefreshStatus.endHeaderRefresh : RefreshStatus.endFooterRefresh
                
//                    outPut.refreshStatus.map{
//                        result in
//                              result = isReloadData ? RefreshStatus.endHeaderRefresh : RefreshStatus.endFooterRefresh
//                        return  result
//                    }
//                print("下载或者更新")
        },
            onError: {
                error in
                print(error)
        },
            onCompleted: {
                print("completed")
        },
            onDisposed: {
                print("Disposed")
        })
        
        
        
        return outPut
    }

}



extension YMTTaoBaoViewModel{
    
    struct Input {
        
        let category : HomePageApi

    }
    
    
    struct Output {
        
        let  dataSource  : Observable<[YMTTaoBaoModel]>
        
        //监听是下拉刷新还是加载
        let requestCommond = PublishSubject<Bool>()

        //告诉控制器当前刷新状态
        var refreshStatus : Observable <RefreshStatus>
    }
    
}
