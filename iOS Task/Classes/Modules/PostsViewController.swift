//
//  PostsViewController.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PostsViewController: BaseViewController<PostsViewModel> {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configure(with viewModel: PostsViewModel) {
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.getPostsWithRetryOnFail()
            })
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        viewModel.setupDataSource()
        getPostsWithRetryOnFail()
        
        let dataSource = RxTableViewSectionedReloadDataSource<RxTableSection<PostCellViewModel>>(configureCell: { section, tableView, indexPath, cellViewModel in
            let cell = tableView.dequeueReusableCell(for: indexPath, ofType: PostCell.self)
            cell.viewModel = cellViewModel
            return cell
        })
        
        viewModel.dataSource.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.dataSourceReloading.map { [weak self] isReloading in
            let isRefreshControlActive = self?.tableView.refreshControl?.isRefreshing ?? false
        
            if isReloading && !isRefreshControlActive {
                self?.navigationItem.showLoadingSpinner()
            } else {
                self?.navigationItem.removeLoadingSpinner()
            }
            
            if !isReloading {
                self?.tableView.refreshControl?.endRefreshing()
            }
            }.subscribe().disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(PostCellViewModel.self))
            .bind { [weak self] indexPath, cellViewModel in
                self?.viewModel.showPost.accept((cellViewModel.post, indexPath))
            }.disposed(by: disposeBag)
    }
}

//MARK: - Lifecycle
extension PostsViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.indexPathsForVisibleRows?.forEach { tableView.deselectRow(at: $0, animated: true) }
    }
}

//MARK: - Fetch requests
extension PostsViewController {
    private func getPostsWithRetryOnFail() {
        self.viewModel.getPosts {
            self.getPostsWithRetryOnFail()
            }.disposed(by: self.disposeBag)
    }
}
