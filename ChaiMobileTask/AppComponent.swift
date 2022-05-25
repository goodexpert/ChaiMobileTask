//
//  AppComponent.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 25/05/22.
//

import Foundation

protocol AppComponentProtocol {
    var repository: TaskRepository { get }
    var viewModel: TaskViewModel { get }
}

struct AppComponent: AppComponentProtocol {
    static let shared = AppComponent()

    private init() { }
    
    var repository: TaskRepository {
        return TaskRepository(managedObjectContext: Persistence.shared.managedObjectContext)
    }
    
    var viewModel: TaskViewModel {
        return TaskViewModel(repository: repository)
    }
    
    static var taskEntity: TaskEntity {
        let newTask = TaskEntity(context: Persistence.shared.managedObjectContext)
        newTask.title = "newTask".localized
        newTask.date = .now
        return newTask
    }
}
