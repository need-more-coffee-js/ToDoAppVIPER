//
//  TaskDetailPresenterTests.swift
//  TaskDetailPresenterTests
//
//  Created by Денис Ефименков on 06.03.2025.
//

import XCTest
@testable import ToDoApp

class MockTaskDetailView: TaskDetailViewProtocol {
    var showTaskCalled = false
    var showErrorCalled = false

    func showTask(_ task: Task) {
        showTaskCalled = true
    }

    func showError(_ message: String) {
        showErrorCalled = true
    }
}

class MockTaskDetailInteractor: TaskDetailInteractorProtocol {
    var createTaskCalled = false
    var updateTaskCalled = false

    func createTask(title: String, description: String) {
        createTaskCalled = true
    }

    func updateTask(_ task: Task, title: String, description: String) {
        updateTaskCalled = true
    }
}

class TaskDetailPresenterTests: XCTestCase {
    var presenter: TaskDetailPresenter!
    var mockView: MockTaskDetailView!
    var mockInteractor: MockTaskDetailInteractor!

    override func setUp() {
        super.setUp()
        mockView = MockTaskDetailView()
        mockInteractor = MockTaskDetailInteractor()
        presenter = TaskDetailPresenter()
        presenter.view = mockView
        presenter.interactor = mockInteractor
    }

    func testCreateTask() {
        // Действие
        presenter.saveTask(title: "New Task", description: "Description")

        // Проверка
        XCTAssertTrue(mockInteractor.createTaskCalled)
    }

    func testUpdateTask() {
        // Подготовка
        let task = Task(context: CoreDataStack.shared.context)
        presenter.task = task

        // Действие
        presenter.saveTask(title: "Updated Task", description: "Updated Description")

        // Проверка
        XCTAssertTrue(mockInteractor.updateTaskCalled)
    }
}
