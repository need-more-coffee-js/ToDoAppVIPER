//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 06.03.2025.
//

import UIKit

class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusSwitch = UISwitch()

    var onStatusChanged: ((Bool) -> Void)? // Замыкание для обработки изменения статуса

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Настройка titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }

        // Настройка statusLabel
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }

        // Настройка dateLabel
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }

        // Настройка statusSwitch
        statusSwitch.addTarget(self, action: #selector(statusSwitchChanged), for: .valueChanged)
        contentView.addSubview(statusSwitch)
        statusSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(with task: Task) {
        titleLabel.text = task.title
        updateStatusLabel(isCompleted: task.isCompleted)
        dateLabel.text = "Created: \(formattedDate(task.createdAt))"
        statusSwitch.isOn = task.isCompleted
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    @objc private func statusSwitchChanged() {
        let isCompleted = statusSwitch.isOn
        updateStatusLabel(isCompleted: isCompleted) // Обновляем текст статуса
        onStatusChanged?(isCompleted) // Вызываем замыкание для обновления данных
    }

    private func updateStatusLabel(isCompleted: Bool) {
        statusLabel.text = isCompleted ? "✅ Completed" : "❌ Not Completed"
    }
}
