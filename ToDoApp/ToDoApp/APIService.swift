//
//  APIService.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//

import Foundation

struct TodoResponse: Codable {
    let todos: [TaskResponse]
    let total: Int
    let skip: Int
    let limit: Int
}

struct TaskResponse: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

protocol APIServiceProtocol {
    func fetchTasks(completion: @escaping ([TaskResponse]) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchTasks(completion: @escaping ([TaskResponse]) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching tasks: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let todoResponse = try decoder.decode(TodoResponse.self, from: data)
                print("Fetched \(todoResponse.todos.count) tasks from API")
                completion(todoResponse.todos)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
