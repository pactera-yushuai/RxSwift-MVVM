//
//  YMTProductDetailsViewModel.swift
//  Yamoto
//
//  Created by pactera on 2020/11/2.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift

class YMTProductDetailsViewModel: NSObject {

    class func loadHomePageLocalDate() -> Observable<[HomePage]> {
    let  result1 = [ "result" : [
                           ["title": "第一条" ,"array2": [["title":"sdfadf"]]],
                           ["title": "看了,又看" ,"array2": [["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"],["title":"sdfadf"]]]
                       ]
        ]
        
    let aaa =  YMTHomePage(JSON: result1)
       return Observable.just(aaa)
        .map{
        ($0)?.result ?? []
        }
    }
}
