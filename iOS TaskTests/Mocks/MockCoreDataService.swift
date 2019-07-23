//
//  MockCoreDataService.swift
//  iOS TaskTests
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

class MockCoreDataService: ICoreDataService {
    func loadPersistentContainer(completion: @escaping () -> Void) {}
    
    var persistentContainer: NSPersistentContainer!
    
    required init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAllPosts() -> [Post] {
        return []
    }
    
    func createOrUpdatePosts(with array: [[String : Any]]) -> [Post] {
        let posts = Post.createOrUpdate(with: array, in: persistentContainer.viewContext)
        return posts
    }
}
