//
//  TabBaoViewModel.swift
//  Yamoto
//
//  Created by pactera on 2020/11/13.
//  Copyright © 2020 pactera. All rights reserved.
//

import RxSwift
import RxCocoa




class TabBaoViewModel{
    
    var datasource : Observable<[YMTTaoBaoModel]>
    
    let requestCommond : PublishSubject<Bool>

    let refreshStatus : Driver <RefreshStatus>
    
    let index : Int
    
    let APi : HomePageApi
    
    init(
        dependency:(
        
            HomePageApi
        )
    ) {
        
        APi  = dependency
        index = 0
        requestCommond = PublishSubject<Bool>()
        
        refreshStatus = Driver.never()
     //   let  result1 = ["array2" : [ ["title": "第一条" ,"imageUrl":["aaaa","aaaa"]],
//                                     ["title": "第二条" ,"imageUrl":["aaaa","aaaa"]],
//                                                           ["title": "第三条" ,"imageUrl":["aaaa","aaaa"]],
//                                                           ["title": "第四条" ,"imageUrl":["aaaa","aaaa"]],
//                                                           ["title": "第五条" ,"imageUrl":["aaaa","aaaa"]],
//                                                          ]]
        
        
        let elements = BehaviorRelay<[YMTTaoBaoModel]>(value: [])

        
      //  let aaa =  YMTTaoBaoModel(JSON: result1)
        datasource =  elements.asObservable()
    }
    
     
    func getListDate(index :Int ,pages :Int) -> Observable<[YMTTaoBaoModel]>{
        
        
    requestCommond.subscribe(
            onNext :{
        
            isReloadData in
        
            let page: Int =  isReloadData ? 0 : self.index + 10
            
            
                    
                
        print(page)
        
        let  result1 = ["array2" : [ ["title": "第一条" ,"imageUrl":["aaaa","aaaa"]],
                                     ["title": "第二条" ,"imageUrl":["aaaa","aaaa"]],
                                                           ["title": "第三条" ,"imageUrl":["aaaa","aaaa"]],
                                                           ["title": "第四条" ,"imageUrl":["aaaa","aaaa"]],
                                                           ["title": "第五条" ,"imageUrl":["aaaa","aaaa"]],
                                                          ]]
             
                let a =  ["title": "第一条" ,"imageUrl":["aaaa","aaaa"]] as [String : Any]
                
                let aa : TaoBao = TaoBao(JSON: a)!
                
                
        let aaa =  YMTTaoBaoModel(JSON: result1)
        
        self.datasource.map{
               result in
           // result + aa
            return result
        }
    })
        
        return  self.datasource
    }
    
    

}


