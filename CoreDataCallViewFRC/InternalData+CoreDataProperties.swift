//
//  InternalData+CoreDataProperties.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/20/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//
//

import Foundation
import CoreData


extension InternalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InternalData> {
        return NSFetchRequest<InternalData>(entityName: "InternalData")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var title: String?

}
