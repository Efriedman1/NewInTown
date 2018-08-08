//
//  CoreData.swift
//  NewInTown
//
//  Created by Eric Friedman on 8/7/18.
//  Copyright © 2018 Eric Friedman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataHelper{
    static let context: NSManagedObjectContext = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = delegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newBusiness() -> SavedSearch {
        let saved = NSEntityDescription.insertNewObject(forEntityName: "SavedSearch", into: context) as! SavedSearch
        return saved
    }
    
    static func saveBusiness() {
        do {
            print("Context \(String(describing: context.name))")
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(savedSearch: SavedSearch){
        context.delete(savedSearch)
        saveBusiness()
    }
    
    static func retrieveBusinesses() -> [SavedSearch] {
        do {
            let fetchRequest = NSFetchRequest<SavedSearch>(entityName: "SavedSearch")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}
