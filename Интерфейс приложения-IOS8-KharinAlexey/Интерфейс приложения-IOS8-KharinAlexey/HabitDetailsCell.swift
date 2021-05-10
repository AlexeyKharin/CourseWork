//
//  HabitDetailsCell.swift
//  Интерфейс приложения-IOS8-KharinAlexey
//
//  Created by Alexey Kharin on 11.03.2021.
//

import UIKit
class HabitDetailsCell: UITableViewCell {
    
    var dates: String? {
        didSet {
            date.text = dates
        }
    }
    
    let date: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.toAutoLayout()
        label.backgroundColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        contentView.addSubview(date)
        let constraints = [
            date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

