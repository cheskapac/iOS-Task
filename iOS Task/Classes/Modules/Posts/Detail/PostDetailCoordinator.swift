//
//  PostDetailCoordinator.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/30/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift

class PostDetailCoordinator: BaseCoordinator<Post> {
    private let post: Post
    private let rootViewController: UIViewController
    
    init(post: Post, rootViewController: UIViewController) {
        self.post = post
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Post> {
        let viewModel = PostDetailViewModel(post: post,
                                            dataService: Locator.dataService,
                                            alertService: Locator.alertService)
        let controller = PostDetailViewController()
        controller.viewModel = viewModel
        
        rootViewController.navigationController?.pushViewController(controller, animated: true)
        
        return viewModel.post.asObservable().skip(1)
    }
}
