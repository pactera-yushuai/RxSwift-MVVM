//
//  YMTHoemPageListModel.swift
//  Yamoto
//
//  Created by pactera on 2020/11/11.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import ObjectMapper
import RxMoya
import RxDataSources



struct YMTTaoBaoModel :Mappable{
    
        var  array1: [TaoBao]?
        var  array2: [TaoBao]?
    
        init?(map: Map) { }
    
       mutating func mapping(map: Map) {
            array1 <- map["array1"]
            array2 <- map["array2"]
        }
}


struct TaoBao: Mappable {
    
    var imageUrl: Array<String>?
    var title:String?
    var content: String?
    var date: String?
    var imageName : String?
    
   var good_id: Int = 0
   var good_name: String?
   var good_info: String?
   var good_url: String?
   var good_price: String?


    init?(map: Map) { }
    mutating func mapping(map: Map) {
        imageUrl <- map["imageUrl"]
        imageName <- map["imageName"]
        title <- map["title"]
        content <- map["content"]
        date <- map["name"]
        good_id <- map["good_id"]
         good_name <- map["good_name"]
         good_info <- map["good_info"]
         good_url <- map["good_url"]
         good_price <- map["good_price"]
    }
}


extension YMTTaoBaoModel : SectionModelType {
    
    typealias Item = TaoBao

    var items: [TaoBao] {
        return self.array2!
    }

    init(original: YMTTaoBaoModel, items: [Item]) {
        self = original
        self.array2 = items
    }
}




//extension HomePage : SectionModelType {
//
//    typealias Item = Items
//    typealias Identity = String
//
//    var identity: String {
//        return title!
//    }
//
//    var items: [Items] {
//        return self.array2!
//    }
//
//    init(original: HomePage, items: [Item]) {
//        self = original
//        self.array2 = items
//    }
//}
