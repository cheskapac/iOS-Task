//
//  PostsViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/27/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class PostsViewModel {
    var dataSource: Observable<[RxTableSection<PostCellViewModel>]> {
        return cellViewModels.asObservable()
    }
    
    var dataSourceReloading: Observable<Bool> {
        return reloading.asObservable().observeOn(MainScheduler.instance).distinctUntilChanged()
    }
    
    let title = Observable.just("Posts")
    let showPost = PublishRelay<(Post, IndexPath)>()
    private let cellViewModels = BehaviorRelay<[RxTableSection<PostCellViewModel>]>(value: [])
    private let reloading = PublishRelay<Bool>()
    
    let coreService: ICoreDataService
    let dataService: IDataService
    let alertService: IAlertService
    
    init(coreService: ICoreDataService, dataService: IDataService, alertService: IAlertService) {
        self.coreService = coreService
        self.dataService = dataService
        self.alertService = alertService
    }
    
    func updateDataSource(post: Post, at indexPath: IndexPath) {
        var mutableDataSource = cellViewModels.value
        mutableDataSource[indexPath.section].items[indexPath.row].post = post
        cellViewModels.accept(mutableDataSource)
        print("Updating post \(post.title) at row", indexPath.row)
    }
    
    func setupDataSource() {
        let posts = self.coreService.getAllPosts()
        let viewModels = posts.map { PostCellViewModel(post: $0) }
        self.cellViewModels.accept([RxTableSection(items: viewModels)])
    }
    
    func getPosts(retryCallback: (() -> Void)? = nil) -> Disposable {
        self.reloading.accept(true)
        
        return dataService.getAndCachePosts().subscribe { event in
            switch event {
            case .success(let posts):
                let viewModels = posts.map { PostCellViewModel(post: $0) }
                self.cellViewModels.accept([RxTableSection(items: viewModels)])
                self.reloading.accept(false)
            case .error(let error):
                self.showRetryAlert(error: error, retryCallback: retryCallback)
            }
        }
    }
    
    func showRetryAlert(error: Error, retryCallback: (() -> Void)?) {
        alertService.showRetryAlert(title: "Error",
                                    message: error.localizedDescription,
                                    retryCallback: retryCallback) { self.reloading.accept(false) }
    }
}
