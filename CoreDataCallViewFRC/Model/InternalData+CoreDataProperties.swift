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
import UIKit

extension InternalData: ItemCellViewModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InternalData> {
        return NSFetchRequest<InternalData>(entityName: "InternalData")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var title: String?
    @NSManaged public var file: String?

    func getTitle()->String {
        return self.title ?? ""
    }
    func getPicture()->Data? {
        if let image = UIImage(named: "\(index)"), let data:Data = UIImageJPEGRepresentation(image, 1.0) {
            return data
        }
        return self.picture
    }
}
