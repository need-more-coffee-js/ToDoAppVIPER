//
//  TaskDetailPresenter.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//
protocol TaskDetailPresenterProtocol {
    var task: Task? { get set }
    func viewDidLoad()
    func saveTask(title: String, description: String)
}

class TaskDetailPresenter: TaskDetailPresenterProtocol {
    var view: TaskDetailViewProtocol!
    var interactor: TaskDetailInteractorProtocol!
    var router: TaskDetailRouterProtocol!

    var task: Task?

    func viewDidLoad() {
        if let task = task {
            view.showTask(task)
        }
    }

    func saveTask(title: String, description: String) {
        if let task = task {
            // Редактирование существующей задачи
            interactor.updateTask(task, title: title, description: description)
        } else {
            // Создание новой задачи
            interactor.createTask(title: title, description: description)
        }
        router.dismiss()
    }
}
