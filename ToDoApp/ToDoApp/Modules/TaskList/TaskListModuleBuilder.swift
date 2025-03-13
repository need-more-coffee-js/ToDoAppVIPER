//
//  TaskListModuleBuilder.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 13.03.2025.
//

import Foundation

class TaskListModuleBuilder {
    static func setupTaskListModule(with view: TaskListViewController) {
        let presenter = TaskListPresenter()
        let interactor = TaskListInteractor()
        let router = TaskListRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
    }
}
