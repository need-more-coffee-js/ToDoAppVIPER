//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Денис Ефименков on 06.03.2025.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"

    private let circleView = UIView()
    private let checkmarkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    var onStatusChanged: ((Bool) -> Void)? //обработка изменения статуса

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        circleView.layer.cornerRadius = 15
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }


        checkmarkImageView.image = UIImage(systemName: "checkmark")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.isHidden = true
        circleView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(22)
        }

        // Настройка titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(circleView.snp.trailing).offset(8)
        }

        // Настройка statusLabel
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(circleView.snp.trailing).offset(8)
        }

        // Настройка dateLabel
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.leading.equalTo(circleView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    func configure(with task: Task) {
        titleLabel.text = task.title
        dateLabel.text = formattedDate(task.createdAt)
        updateCircleView(isCompleted: task.isCompleted)
    }
    
    private func updateCircleView(isCompleted: Bool) {
        if isCompleted {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
    }
}








