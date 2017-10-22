//
//  DataController.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/20/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import RealmSwift

var modelArray = ["First", "Second", "Third", "Eleventh","Hello there", "Fuck off", "Son of a busquit", "Game over"]

func generateRandomObjects(backgroundContext: NSManagedObjectContext) {
    //С какой-то задержкой
    
    var realmArray: [RmItem] = []
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    backgroundContext.perform {
        
        for i in 1..<51 {
            let newItem = Item(context: backgroundContext)
            let newItemInternalPicture = InternalData(context: backgroundContext)
            let rmItem = RmItem()
            rmItem.title = "This is \(i)"
            newItem.title = "This is \(i)"
            newItemInternalPicture.title = "This is \(i)"
            for index in (1...9).reversed() {
                if i % index == 0, let image = UIImage(named: "\(index)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                    newItem.picture = data
                    newItem.file = "\(index)"
                    newItemInternalPicture.picture = data
                    newItemInternalPicture.file = "\(index)"
                    rmItem.picture = data
                    rmItem.file = "\(index)"
                    break
                }
            }
 
            realmArray.append(rmItem)
        }
        
//        for (index,everyItem) in modelArray.enumerated() {
//            let newItem = Item(context: context)
//            newItem.title = everyItem
//            if let image = UIImage(named: "\(index+1)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
//                newItem.picture = data
//            }
//            //newItem.picture =
//        }
        do {
            try backgroundContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
        }
        // Get the default Realm
        let realm = try! Realm()
        // Persist your data easily
        try! realm.write {
            realm.add(realmArray)
        }
            

    }
    }
}
