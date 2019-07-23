//
//  PostCell.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    private let companyNameLabel: UILabel = { return UILabel() }()
    private let userNameLabel: UILabel = { return UILabel() }()
    private let titleLabel: UILabel = { return UILabel() }()
    private let bodyLabel: UILabel = { return UILabel() }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,
                                                       userNameLabel,
                                                       titleLabel,
                                                       bodyLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.setCustomSpacing(10, after: userNameLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

//MARK: - IViewModelBindable
extension PostCell: IViewModelBindable {
    func configure(with viewModel: PostCellViewModel) {
        companyNameLabel.configure(viewModel.companyNameLabel)
        userNameLabel.configure(viewModel.userNameLabel)
        titleLabel.configure(viewModel.titleLabel)
        bodyLabel.configure(viewModel.bodyLabel)
    }
}
