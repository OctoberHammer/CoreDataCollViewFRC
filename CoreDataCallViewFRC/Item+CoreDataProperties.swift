//
//  Item+CoreDataProperties.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/20/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var picture: Data?

}