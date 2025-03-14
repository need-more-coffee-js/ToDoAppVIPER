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
        view.backgroundColor = .white
        presenter.viewDidLoad()

        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(saveButton)

        setupTitleTextField()
        setupDescriptionTextField()
        setupSaveButton()

        setupConstraints()
    }

    private func setupTitleTextField() {
        titleTextField.placeholder = "Название задачи"
        titleTextField.borderStyle = .roundedRect
    }

    private func setupDescriptionTextField() {
        descriptionTextField.placeholder = "Описание задачи"
        descriptionTextField.borderStyle = .roundedRect
    }

    private func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        let title = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        presenter.saveTask(title: title, description: description)
    }

    private func setupConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
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




