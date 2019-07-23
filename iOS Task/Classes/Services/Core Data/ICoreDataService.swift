//
//  ICoreDataService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

protocol ICoreDataService {
    init(persistentContainer: NSPersistentContainer)
    func getAllPosts() -> [Post]
    func createOrUpdatePosts(with array: [[String: Any]]) -> [Post]
    func loadPersistentContainer(completion: @escaping () -> Void)
}
