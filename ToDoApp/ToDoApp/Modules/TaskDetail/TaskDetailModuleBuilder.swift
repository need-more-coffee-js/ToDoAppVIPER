//
//  TaskDetailModuleBuilder.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import UIKit


class TaskDetailModuleBuilder {
    static func build(with task: Task?) -> UIViewController {
        let view = TaskDetailViewController()
        let presenter = TaskDetailPresenter()
        let interactor = TaskDetailInteractor()
        let router = TaskDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view

        // Передаем задачу в Presenter
        presenter.task = task

        return view
    }
}
