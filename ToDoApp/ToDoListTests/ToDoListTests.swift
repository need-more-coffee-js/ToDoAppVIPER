//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Денис Ефименков on 06.03.2025.
//

import XCTest
@testable import ToDoApp

class MockAPIService: APIServiceProtocol {
    var fetchTasksCalled = false
    var mockTasks: [TaskResponse] = []

    func fetchTasks(completion: @escaping ([TaskResponse]) -> Void) {
        fetchTasksCalled = true
        completion(mockTasks)
    }
}

class APIServiceTests: XCTestCase {
    var apiService: MockAPIService!

    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
    }

    func testFetchTasks() {
        // Подготовка
        let expectedTasks = [
            TaskResponse(id: 1, todo: "Task 1", completed: false, userId: 1),
            TaskResponse(id: 2, todo: "Task 2", completed: true, userId: 2)
        ]
        apiService.mockTasks = expectedTasks

        // Действие
        var resultTasks: [TaskResponse] = []
        apiService.fetchTasks { tasks in
            resultTasks = tasks
        }

        // Проверка
        XCTAssertTrue(apiService.fetchTasksCalled)
        XCTAssertEqual(resultTasks.count, expectedTasks.count)
        XCTAssertEqual(resultTasks[0].todo, "Task 1")
        XCTAssertEqual(resultTasks[1].todo, "Task 2")
    }
}
