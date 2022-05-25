//
//  TaskViewModel.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 23/05/22.
//

import Foundation

class TaskViewModel : ObservableObject {
    private let repository: TaskRepository
    
    @Published var taskEntities: [TaskEntity] = []
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func addTask(title: String) {
        do {
            try repository.create(title: title)
        } catch let error {
            print("Error creating. \(error)")
        }
        fetch()
    }
    
    func delete(_ taskEntity: TaskEntity) {
        do {
            try repository.delete(taskEntity)
        } catch let error {
            print("Error deleting. \(error)")
        }
        fetch()
    }
    
    func fetch() {
        do {
            taskEntities = try repository.fetch()
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func save() {
        do {
            try repository.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
