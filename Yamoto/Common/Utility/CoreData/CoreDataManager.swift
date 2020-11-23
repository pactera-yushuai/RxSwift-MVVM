
//
//  File.swift
//  Yamoto
//
//  Created by pactera on 2020/11/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // 单例
       static let shared = CoreDataManager()
       
        var dataArray: [AppInfo] = [AppInfo]()
       
       // 拿到AppDelegate中创建好了的NSManagedObjectContext
       lazy var context: NSManagedObjectContext = {
           let context = ((UIApplication.shared.delegate) as! AppDelegate).context
           return context
       }()
       
       // 更新数据
       private func saveContext() {
           do {
               try context.save()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
       
 
       // 增加版本信息数据
       func savePersonWith(appInfo: AppInfo) {
        
           let Info = NSEntityDescription.insertNewObject(forEntityName: "YamotoData", into: context) as! AppInfo

            Info.lastVersion = appInfo.lastVersion
            Info.currentVersion = appInfo.currentVersion
            Info.enterbackgroundTime = appInfo.enterbackgroundTime
        
            //person.title = title
            //person.id = id
            //person.content = "内容"
            //person.imageData = "aaassdfa".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
           saveContext()
       }
       
       // 根据姓名获取数据
       func getPersonWith(title: String) -> [AppInfo] {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "name == %@", title)
           do {
               let result: [AppInfo] = try context.fetch(fetchRequest)
               return result
           } catch {
               fatalError();
           }
       }
       
       // 获取所有数据
       func getAllPerson() -> [AppInfo] {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           do {
               let result = try context.fetch(fetchRequest)
               return result
           } catch {
               fatalError();
           }
       }
       
       // 根据姓名修改数据
       func changePersonWith(title: String, newTitle: String, newId: Int16) {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title == %@", title)
           do {
               let result = try context.fetch(fetchRequest)
               for  Info in result {
               // Info.title = title
//                   person.id = newId
//                   person.title = newTitle
               }
           } catch {
               fatalError();
           }
           saveContext()
       }
       
       // 根据姓名删除数据
       func deleteWith(title: String) {
           let fetchRequest: NSFetchRequest = AppInfo.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title == %@", title)
           do {
               let result = try context.fetch(fetchRequest)
               for Info in result {
                   context.delete(Info)
               }
           } catch {
               fatalError();
           }
           saveContext()
       }
       
       // 删除所有数据
       func deleteAllPerson() {
           let result = getAllPerson()
           for Info in result {
               context.delete(Info)
           }
           saveContext()
       }
}
