//
//  SavedSearch+CoreDataProperties.swift
//  
//
//  Created by Eric Friedman on 8/5/18.
//
//

import Foundation
import CoreData


extension SavedSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedSearch> {
        return NSFetchRequest<SavedSearch>(entityName: "SavedSearch")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var price: String?
    @NSManaged public var reviews: Int32

}
