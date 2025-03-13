//
//  TaskListRouter.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import UIKit

protocol TaskListRouterProtocol {
    func navigateToTaskDetail(_ task: Task?)
}

class TaskListRouter: TaskListRouterProtocol {
    weak var view: UIViewController!

    func navigateToTaskDetail(_ task: Task?) {
        let taskDetailVC = TaskDetailModuleBuilder.build(with: task)
        view.navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}
