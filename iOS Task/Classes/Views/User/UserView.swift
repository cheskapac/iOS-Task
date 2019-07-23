//
//  UserView.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

final class UserView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    let emailTextView: UITextView = {
        let emailTextView = UITextView()
        return emailTextView
    }()
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        return addressLabel
    }()
    let phoneTextView: UITextView = {
        let phoneTextView = UITextView()
        return phoneTextView
    }()
    let companyNameLabel: UILabel = {
        let companyNameLabel = UILabel()
        return companyNameLabel
    }()
    
    convenience init() {
        self.init(frame: .zero)
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            emailTextView,
            phoneTextView,
            companyNameLabel,
            addressLabel
            ])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(imageView)
        
        let screenBounds = UIScreen.main.bounds
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: screenBounds.width * 0.2),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

//MARK: - IViewModelBindable
extension UserView: IViewModelBindable {
    func configure(with viewModel: UserViewViewModel) {
        imageView.configure(viewModel.imageView)
        nameLabel.configure(viewModel.nameLabel)
        emailTextView.configure(viewModel.emailTextView)
        addressLabel.configure(viewModel.addressLabel)
        phoneTextView.configure(viewModel.phoneTextView)
        companyNameLabel.configure(viewModel.companyNameLabel)
    }
    
    func updateImage() {
        imageView.configure(viewModel.imageView)
    }
}
