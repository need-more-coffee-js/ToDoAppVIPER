//
//  TaskCardView.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 14.03.2025.
//

import UIKit
import SnapKit

class TaskCardView: UIView {
    // Заголовок
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Зарядка утром"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    // Количество задач
    private let taskCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    // Иконка (опционально)
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet") // Пример иконки из SF Symbols
        imageView.tintColor = .gray
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTodoCount()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        // Настройка внешнего вида карточки
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        // Добавляем элементы на карточку
        addSubview(titleLabel)
        addSubview(taskCountLabel)
        addSubview(iconImageView)

        // Устанавливаем констрейнты с помощью SnapKit
        setupConstraints()
    }

    private func setupConstraints() {
        // Иконка
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        // Заголовок
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        // Количество задач
        taskCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupTodoCount() {
    }
}
