//
//  CoreDataServiceTests.swift
//  CoreDataServiceTests
//
//  Created by Денис Ефименков on 06.03.2025.
//

import XCTest
@testable import ToDoApp
import CoreData

class MockCoreDataService: CoreDataServiceProtocol {
    var saveTasksCalled = false
    var fetchTasksCalled = false
    var deleteTaskCalled = false
    var searchTasksCalled = false

    var mockTasks: [Task] = []

    func saveTasks(_ tasks: [TaskResponse]) {
        saveTasksCalled = true
    }

    func fetchTasks() -> [Task] {
        fetchTasksCalled = true
        return mockTasks
    }

    func deleteTask(_ task: Task) {
        deleteTaskCalled = true
    }

    func searchTasks(with query: String) -> [Task] {
        searchTasksCalled = true
        return mockTasks.filter { $0.title?.contains(query) == true }
    }

    func saveContext() {}
}

class CoreDataServiceTests: XCTestCase {
    var coreDataService: MockCoreDataService!

    override func setUp() {
        super.setUp()
        coreDataService = MockCoreDataService()
    }

    func testSaveTasks() {
        // Подготовка
        let tasks = [
            TaskResponse(id: 1, todo: "Task 1", completed: false, userId: 1)
        ]

        // Действие
        coreDataService.saveTasks(tasks)

        // Проверка
        XCTAssertTrue(coreDataService.saveTasksCalled)
    }

    func testFetchTasks() {
        // Подготовка
        let task = Task(context: CoreDataStack.shared.context)
        task.title = "Task 1"
        coreDataService.mockTasks = [task]

        // Действие
        let tasks = coreDataService.fetchTasks()

        // Проверка
        XCTAssertTrue(coreDataService.fetchTasksCalled)
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].title, "Task 1")
    }

    func testDeleteTask() {
        // Подготовка
        let task = Task(context: CoreDataStack.shared.context)
        task.title = "Task 1"

        // Действие
        coreDataService.deleteTask(task)

        // Проверка
        XCTAssertTrue(coreDataService.deleteTaskCalled)
    }

    func testSearchTasks() {
        // Подготовка
        let task = Task(context: CoreDataStack.shared.context)
        task.title = "Task 1"
        coreDataService.mockTasks = [task]

        // Действие
        let tasks = coreDataService.searchTasks(with: "Task")

        // Проверка
        XCTAssertTrue(coreDataService.searchTasksCalled)
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].title, "Task 1")
    }
}
