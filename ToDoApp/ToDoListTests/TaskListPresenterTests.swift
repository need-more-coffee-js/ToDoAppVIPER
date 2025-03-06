//
//  TaskListPresenterTests.swift
//  TaskListPresenterTests
//
//  Created by Денис Ефименков on 06.03.2025.
//

import XCTest
@testable import ToDoApp

class MockTaskListView: TaskListViewProtocol {
    var showTasksCalled = false
    var removeTaskCalled = false
    var showErrorCalled = false

    func showTasks(_ tasks: [Task]) {
        showTasksCalled = true
    }

    func removeTask(_ task: Task) {
        removeTaskCalled = true
    }

    func showError(_ message: String) {
        showErrorCalled = true
    }
}

class MockTaskListInteractor: TaskListInteractorProtocol {
    var fetchTasksCalled = false
    var deleteTaskCalled = false
    var searchTasksCalled = false

    func fetchTasks() {
        fetchTasksCalled = true
    }

    func deleteTask(_ task: Task) {
        deleteTaskCalled = true
    }

    func searchTasks(with query: String) {
        searchTasksCalled = true
    }
}

class TaskListPresenterTests: XCTestCase {
    var presenter: TaskListPresenter!
    var mockView: MockTaskListView!
    var mockInteractor: MockTaskListInteractor!

    override func setUp() {
        super.setUp()
        mockView = MockTaskListView()
        mockInteractor = MockTaskListInteractor()
        presenter = TaskListPresenter()
        presenter.view = mockView
        presenter.interactor = mockInteractor
    }

    func testViewDidLoad() {
        // Действие
        presenter.viewDidLoad()

        // Проверка
        XCTAssertTrue(mockInteractor.fetchTasksCalled)
    }

    func testDeleteTask() {
        // Подготовка
        let task = Task(context: CoreDataStack.shared.context)

        // Действие
        presenter.deleteTask(task)

        // Проверка
        XCTAssertTrue(mockInteractor.deleteTaskCalled)
        XCTAssertTrue(mockView.removeTaskCalled)
    }

    func testSearchTasks() {
        // Действие
        presenter.searchTasks(with: "Task")

        // Проверка
        XCTAssertTrue(mockInteractor.searchTasksCalled)
    }
}
