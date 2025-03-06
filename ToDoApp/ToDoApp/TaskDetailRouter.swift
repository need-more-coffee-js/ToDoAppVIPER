//
//  TaskDetailRouter.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import UIKit

protocol TaskDetailRouterProtocol {
    func dismiss()
}

class TaskDetailRouter: TaskDetailRouterProtocol {
    weak var view: UIViewController!

    func dismiss() {
        view.navigationController?.popViewController(animated: true)
    }
}
