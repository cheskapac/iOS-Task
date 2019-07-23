//
//  CoreDataService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import CoreData

final class CoreDataService: NSObject, ICoreDataService {
    var persistentContainer: NSPersistentContainer!
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func loadPersistentContainer(completion: @escaping () -> Void) {
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            
            self.viewContext.automaticallyMergesChangesFromParent = true
            completion()
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func save(_ context: NSManagedObjectContext, completion: (() -> Void)? = nil) {
        if context.hasChanges {
            do {
                try context.save()
                completion?()
            } catch {
                print("@@ [Core Data] Error saving:", error.localizedDescription)
            }
        }
    }
}

extension CoreDataService {
    func getAllPosts() -> [Post] {
        return Post.getAll(in: self.viewContext)
    }
    
    func createOrUpdatePosts(with array: [[String: Any]]) -> [Post] {
        let posts = Post.createOrUpdate(with: array, in: self.viewContext)
        self.save(self.viewContext)
        return posts
    }
}
