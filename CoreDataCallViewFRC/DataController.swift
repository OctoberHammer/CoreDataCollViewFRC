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
var modelArray = ["First", "Second", "Third", "Eleventh","Hello there", "Fuck off", "Son of a busquit", "Game over"]

func generateRandomObjects(backgroundContext: NSManagedObjectContext) {
    //С какой-то задержкой
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    backgroundContext.perform {
        
        for i in 1..<51 {
            let newItem = Item(context: backgroundContext)
            let newItemInternalPicture = InternalData(context: backgroundContext)
            newItem.title = "This is \(i)"
            newItemInternalPicture.title = "This is \(i)"
            if i % 9 == 0, let image = UIImage(named: "\(9)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            }else if i % 8 == 0, let image = UIImage(named: "\(8)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if  i % 7 == 0, let image = UIImage(named: "\(7)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if  i % 6 == 0, let image = UIImage(named: "\(6)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if  i % 5 == 0, let image = UIImage(named: "\(5)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else  if i % 4 == 0, let image = UIImage(named: "\(4)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if i % 3 == 0, let image = UIImage(named: "\(3)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if i % 2 == 0, let image = UIImage(named: "\(2)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            } else if i % 1 == 0, let image = UIImage(named: "\(1)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                newItem.picture = data
                newItemInternalPicture.picture = data
            }
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
    }
    }
}
