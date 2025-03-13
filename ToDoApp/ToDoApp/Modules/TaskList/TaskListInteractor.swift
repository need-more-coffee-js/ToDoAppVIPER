//
//  TaskListInteractor.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//
import UIKit

protocol TaskListInteractorProtocol{
    func deleteTask(_ task: Task)
    func searchTasks(with query: String)
    func fetchTasks()
    func updateTaskStatus(_ task: Task)
}

class TaskListInteractor: TaskListInteractorProtocol {
    var presenter: TaskListPresenterProtocol!
    private let apiService: APIServiceProtocol
    private let coreDataService: CoreDataServiceProtocol

    init(apiService: APIServiceProtocol = APIService(), coreDataService: CoreDataServiceProtocol = CoreDataService()) {
        self.apiService = apiService
        self.coreDataService = coreDataService
    }

    func fetchTasks() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }

            // Загрузка из API
            self.apiService.fetchTasks { apiTasks in
                // Сохранение в CoreData
                self.coreDataService.saveTasks(apiTasks)

                // Загрузка из CoreData
                let tasks = self.coreDataService.fetchTasks()

                // Обновление UI в главном потоке
                DispatchQueue.main.async {
                    self.presenter.didFetchTasks(tasks)
                }
            }
        }
    }

    func deleteTask(_ task: Task) {
        coreDataService.deleteTask(task)
        DispatchQueue.main.async {
            self.presenter.didDeleteTask(task)
        }
    }

    func searchTasks(with query: String) {
        let tasks = coreDataService.searchTasks(with: query)
        DispatchQueue.main.async {
            self.presenter.didFetchTasks(tasks)
        }
    }
    
    func updateTaskStatus(_ task: Task) {
        CoreDataStack.shared.saveContext()
    }
}
