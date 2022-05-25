//
//  TaskRepository.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 24/05/22.
//

import Foundation
import CoreData

protocol TaskRepositoryProtocol {
    func create(title: String) throws
    func delete(_ taskEntity: TaskEntity) throws
    func fetch() throws -> [TaskEntity]
    func save() throws
}

class TaskRepository : TaskRepositoryProtocol {
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func create(title: String) throws {
        let newTask = TaskEntity(context: managedObjectContext)
        newTask.title = title
        newTask.date = .now
        try save()
    }
    
    func delete(_ taskEntity: TaskEntity) throws {
        managedObjectContext.delete(taskEntity)
        try save()
    }
    
    func fetch() throws -> [TaskEntity] {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        request.sortDescriptors = [
            NSSortDescriptor(key: "isDone", ascending: true),
            NSSortDescriptor(key: "date", ascending: false)
        ]
        return try managedObjectContext.fetch(request)
    }
    
    func save() throws {
        try managedObjectContext.save()
    }
}
