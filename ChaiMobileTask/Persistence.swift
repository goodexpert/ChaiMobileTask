//
//  Persistence.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 25/05/22.
//

import Foundation
import CoreData

struct Persistence {
    static let shared = Persistence()
    
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "TaskContainer")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("Unable to load persistent stores \(error)")
            }
        })
    }
}
