//
//  PostsCoordinator.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift

class PostsCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = PostsViewModel(coreService: Locator.coreService,
                                       dataService: Locator.dataService,
                                       alertService: Locator.alertService)
        let controller = PostsViewController()
        controller.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: controller)
        
        viewModel.showPost.subscribe(onNext: { post, indexPath in
            self.showPostDetail(post: post,
                                rootViewController: controller)
                .subscribe(onNext: { refreshedPost in
                    viewModel.updateDataSource(post: refreshedPost, at: indexPath)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }
    
    private func showPostDetail(post: Post, rootViewController: UIViewController) -> Observable<Post> {
        let coordinator = PostDetailCoordinator(post: post, rootViewController: rootViewController)
        return coordinate(to: coordinator)
    }
}
