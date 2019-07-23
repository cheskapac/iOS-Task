//
//  IDataService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IDataService {
    func refreshPost(post: Post) -> Single<Post>
    func getAndCachePosts() -> Single<[Post]>
}
