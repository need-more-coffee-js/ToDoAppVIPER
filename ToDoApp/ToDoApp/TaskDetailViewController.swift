//
//  TaskDetailViewController.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 21.02.2025.
//
import UIKit

protocol TaskDetailViewProtocol{
    func showTask(_ task: Task)
    func showError(_ message: String)
}

class TaskDetailViewController: UIViewController, TaskDetailViewProtocol {
    var presenter: TaskDetailPresenterProtocol!

    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        titleTextField.placeholder = "Title"
        descriptionTextField.placeholder = "Description"
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [titleTextField, descriptionTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    @objc private func saveButtonTapped() {
        let title = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        presenter.saveTask(title: title, description: description)
    }

    // MARK: - TaskDetailViewProtocol

    func showTask(_ task: Task) {
        titleTextField.text = task.title
        descriptionTextField.text = task.taskDescription
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
