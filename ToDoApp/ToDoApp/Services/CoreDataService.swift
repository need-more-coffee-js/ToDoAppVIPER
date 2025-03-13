//
//  CoreDataService.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import CoreData

protocol CoreDataServiceProtocol {
    func saveTasks(_ tasks: [TaskResponse])
    func fetchTasks() -> [Task]
    func deleteTask(_ task: Task)
    func searchTasks(with query: String) -> [Task]
    func saveContext()
}

class CoreDataService: CoreDataServiceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    func saveTasks(_ tasks: [TaskResponse]) {
        for task in tasks {
            let newTask = Task(context: context)
            newTask.id = UUID()
            newTask.title = task.todo
            newTask.isCompleted = task.completed
            newTask.createdAt = Date()
        }
        saveContext()
    }

    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func deleteTask(_ task: Task) {
        context.delete(task)
        saveContext()
    }

    func searchTasks(with query: String) -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
        return (try? context.fetch(request)) ?? []
    }

    func saveContext() {
        CoreDataStack.shared.saveContext()
    }
}
