//
//  DataService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

final class DataService: IDataService {
    enum APIEndpoint {
        case posts
        case post(id: NSNumber)
        case user(id: NSNumber)
        
        var value: String {
            switch self {
            case .posts:
                return "https://jsonplaceholder.typicode.com/posts"
            case .post(let postId):
                return "https://jsonplaceholder.typicode.com/posts/\(postId)"
            case .user(let userId):
                return "https://jsonplaceholder.typicode.com/users/\(userId)"
            }
        }
    }
    
    private let manager = SessionManager.default
    private let coreService: ICoreDataService
    private let alertService: IAlertService
    
    init(coreService: ICoreDataService,
         alertService: IAlertService) {
        self.coreService = coreService
        self.alertService = alertService
    }
}

//MARK: - Fetch request
extension DataService {
    private func triggerRequest(endpoint: APIEndpoint) -> Single<DataResponse<Any>> {
        return request(.get, endpoint.value)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}

//MARK: - Get Posts
extension DataService {
    /// Refreshes post from API and updates it to Core Data.
    func refreshPost(post: Post) -> Single<Post> {
        return Single<Post>.create { single -> Disposable in
            let postRequest = self.triggerRequest(endpoint: .post(id: post.id))
            let userRequest = self.triggerRequest(endpoint: .user(id: post.user.id))
            
            return Single.zip(postRequest, userRequest).subscribe { event in
                switch event {
                case .success(let response):
                    guard
                        let postDictionary = response.0.value as? [String: Any],
                        let userDictionary = response.1.value as? [String: Any] else { return  }
                    
                    let combinedDictionaries = self.combine(postsDictionaries: [postDictionary],
                                                            usersDictionaries: [userDictionary])
                    
                    guard let post = self.coreService.createOrUpdatePosts(with: combinedDictionaries).first else { return }
                    single(.success(post))
                case .error(let error):
                    single(.error(error))
                }
            }
        }
    }
    
    /// Triggers all posts fetch request,
    /// subsequently triggers all users detail fetch requests,
    /// updates posts & users relationships within Core Data.
    func getAndCachePosts() -> Single<[Post]> {
        return Single<[Post]>.create { single -> Disposable in
            return self.triggerRequest(endpoint: .posts).map { postsResponse -> Disposable in
                guard let postsDictionaries = postsResponse.result.value as? [[String: Any]] else {
                    return Disposables.create()
                }

                let userIds = postsDictionaries.compactMap { $0["userId"] as? NSNumber }
                let uniqueUserIds = Array(Set(userIds))

                return Single.zip(uniqueUserIds.map { self.triggerRequest(endpoint: .user(id: $0)) }).subscribe { event in
                    switch event {
                    case .success(let usersResponses):
                        let usersDictionaries = usersResponses.compactMap { $0.value as? [String: Any] }

                        let combinedDictionaries = self.combine(postsDictionaries: postsDictionaries,
                                                                usersDictionaries: usersDictionaries)

                        let posts = self.coreService.createOrUpdatePosts(with: combinedDictionaries)
                        single(.success(posts))
                    case .error(let error):
                        single(.error(error))
                    }
                }
            }.subscribe(onSuccess: nil, onError: {
                single(.error($0))
            })
        }
    }
    
    private func getPosts() -> Single<[Post]> {
        return Single<[Post]>.create { single -> Disposable in
            return self.triggerRequest(endpoint: .posts).subscribe { event in
                switch event {
                case .success(let response):
                    guard let postsDictionaries = response.result.value as? [[String: Any]] else { return }
                    let posts = self.coreService.createOrUpdatePosts(with: postsDictionaries)
                    single(.success(posts))
                case .error(let error):
                    single(.error(error))
                }
            }
        }
    }
}

//MARK: - Combine posts & users response data
extension DataService {
    private func combine(postsDictionaries: [[String: Any]],
                         usersDictionaries: [[String: Any]]) -> [[String: Any]] {
        var combinedDictionaries = [[String: Any]]()
        
        postsDictionaries.forEach {
            var mutablePost = $0
            if let userId = $0["userId"] as? NSNumber {
                if let userDictionary = usersDictionaries.first(where: { ($0["id"] as? NSNumber) == userId }) {
                    mutablePost["user"] = userDictionary
                }
                
                combinedDictionaries.append(mutablePost)
            }
        }
        
        return combinedDictionaries
    }
}
