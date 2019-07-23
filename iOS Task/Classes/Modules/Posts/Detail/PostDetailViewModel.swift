//
//  PostDetailViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

final class PostDetailViewModel {
    init(post: Post, dataService: IDataService, alertService: IAlertService) {
        self.post = Variable<Post>(post)
        self.dataService = dataService
        self.alertService = alertService
        self.title = Observable.just(post.user.username)
    }

    let post: Variable<Post>
    let dataService: IDataService
    let alertService: IAlertService
    let title: Observable<String>
    let postRefreshing = BehaviorSubject(value: false)

    var userViewViewModel: UserViewViewModel {
        return UserViewViewModel(post: post.value)
    }

    var isUserPhotoCached: Bool {
        return ImageCache.default.isCached(forKey: post.value.user.photoUrl)
    }

    var postTitleLabel: TextViewModel {
        return TextViewModel(text: post.value.title, color: .primary, font: .heavy(20), alignment: .left)
    }

    var postBodyLabel: TextViewModel {
        return TextViewModel(text: post.value.body, color: .primary, font: .regular(14), alignment: .left)
    }

    func showAddressOnGoogleMaps() {
        let geo = post.value.user.address.geo
        guard let url = URL(string: "https://maps.google.com/?q=\(geo.lat),\(geo.lng)") else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func refreshPost(retryCallback: (() -> Void)?) -> Disposable {
        self.postRefreshing.onNext(true)
        return dataService.refreshPost(post: post.value).subscribe { [weak self] event in
            switch event {
            case .success(let post):
                self?.post.value = post
                self?.postRefreshing.onNext(false)
            case .error(let error):
                self?.showRetryAlert(error: error, retryCallback: retryCallback)
            }
        }
    }

    func showRetryAlert(error: Error, retryCallback: (() -> Void)?) {
        alertService.showRetryAlert(title: "Error",
                                    message: error.localizedDescription,
                                    retryCallback: retryCallback)
        { [weak self] in
            self?.postRefreshing.onNext(false)
        }
    }
}
