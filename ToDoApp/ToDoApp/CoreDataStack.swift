//
//  CoreDataStack.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Failed to load CoreData stack: \(error)")
            }
            print("CoreData store URL: \(storeDescription.url?.absoluteString ?? "Unknown")")
        }
        return container
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
