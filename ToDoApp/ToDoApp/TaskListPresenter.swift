//
//  TaskListPresenter.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

protocol TaskListPresenterProtocol {
    func viewDidLoad()
    func didSelectTask(_ task: Task)
    func deleteTask(_ task: Task)
    func searchTasks(with query: String)
    func didFetchTasks(_ tasks: [Task])
    func didDeleteTask(_ task: Task)
}

class TaskListPresenter: TaskListPresenterProtocol {
    var view: TaskListViewProtocol!
    var interactor: TaskListInteractorProtocol!
    var router: TaskListRouterProtocol!

    func viewDidLoad() {
        interactor.fetchTasks()
    }

    func didSelectTask(_ task: Task) {
        router.navigateToTaskDetail(task)
    }

    func deleteTask(_ task: Task) {
        interactor.deleteTask(task)
    }

    func searchTasks(with query: String) {
        interactor.searchTasks(with: query)
    }

    func didFetchTasks(_ tasks: [Task]) {
        view.showTasks(tasks)
    }

    func didDeleteTask(_ task: Task) {
        view.removeTask(task)
    }
}
