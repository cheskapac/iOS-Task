//
//  PostDetailViewController.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture
import RxCocoa
import RxReachability
import Reachability

class PostDetailViewController: BaseViewController<PostDetailViewModel> {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.refreshControl = UIRefreshControl()
        return scrollView
    }()
    
    private let userView: UserView = {
        let userView = UserView()
        userView.translatesAutoresizingMaskIntoConstraints = false
        return userView
    }()
    
    private let postTitleLabel: UILabel = {
        let postTitleLabel = UILabel()
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return postTitleLabel
    }()
    
    private let postBodyLabel: UILabel = {
        let postBodyLabel = UILabel()
        postBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        return postBodyLabel
    }()
    
    private let networkReachability = Reachability()
    
    override func setupViews() {
        view.addSubview(scrollView)
        
        let separator = UIView()
        separator.backgroundColor = .groupTableViewBackground
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [userView, separator, postTitleLabel, postBodyLabel])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            separator.heightAnchor.constraint(equalToConstant: 0.75),
            separator.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            userView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            postTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            postTitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15),
            
            postBodyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            postBodyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15)
        ])
    }
    
    override func configure(with viewModel: PostDetailViewModel) {
        userView.viewModel = viewModel.userViewViewModel
        postTitleLabel.configure(viewModel.postTitleLabel)
        postBodyLabel.configure(viewModel.postBodyLabel)
    }
}

//MARK: - Life Cycle
extension PostDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.userView.imageView.rounded()
    }
}

//MARK: - Bindings
extension PostDetailViewController {
    private func setupBindings() {
        userView.addressLabel.rx
            .tapGesture()
            .when(.ended)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.showAddressOnGoogleMaps()
            }).disposed(by: disposeBag)
        
        scrollView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.refreshPostWithRetryOnFail()
            }).disposed(by: disposeBag)
        
        viewModel.postRefreshing
            .skip(1)
            .subscribe(onNext: { [weak self] refreshing in
                if !refreshing {
                    self?.reConfigure()
                    self?.scrollView.refreshControl?.endRefreshing()
                }
            }).disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        bindNetworkReachabilityIfNeeded()
    }
    
    private func bindNetworkReachabilityIfNeeded() {
        if viewModel.isUserPhotoCached { return }
        try? networkReachability?.startNotifier()
        
        networkReachability?.rx.isConnected
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                if !self.viewModel.isUserPhotoCached {
                    self.userView.updateImage()
                }
                
                self.networkReachability?.stopNotifier()
            }).disposed(by: disposeBag)
    }
}

//MARK: - Fetch requests
extension PostDetailViewController {
    private func refreshPostWithRetryOnFail() {
        self.viewModel.refreshPost {
            self.refreshPostWithRetryOnFail()
        }.disposed(by: self.disposeBag)
    }
}
