//
//  CoreDataStack.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import CoreData

class CoreDataStack {
        
    let container: NSPersistentContainer
    var backgroundContext: NSManagedObjectContext
    
    init(named: String) {
        // Load Persistence Core Data Store
        container = NSPersistentContainer(name: named)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // Create the context
        backgroundContext = container.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
    }
}
