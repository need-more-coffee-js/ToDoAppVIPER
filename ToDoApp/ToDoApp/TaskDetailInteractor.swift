//
//  TaskDetailInteractor.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import Foundation
protocol TaskDetailInteractorProtocol {
    func createTask(title: String, description: String)
    func updateTask(_ task: Task, title: String, description: String)
}

class TaskDetailInteractor: TaskDetailInteractorProtocol {
    var presenter: TaskDetailPresenterProtocol!
    private let coreDataService: CoreDataServiceProtocol

    init(coreDataService: CoreDataServiceProtocol = CoreDataService()) {
        self.coreDataService = coreDataService
    }

    func createTask(title: String, description: String) {
        let newTask = Task(context: CoreDataStack.shared.context)
        newTask.id = UUID()
        newTask.title = title
        newTask.taskDescription = description
        newTask.createdAt = Date()
        newTask.isCompleted = false

        coreDataService.saveContext()
        presenter.task = newTask
    }

    func updateTask(_ task: Task, title: String, description: String) {
        task.title = title
        task.taskDescription = description
        coreDataService.saveContext()
    }
}
