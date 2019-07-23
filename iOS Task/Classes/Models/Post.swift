//
//  Post.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxDataSources

class Post: NSManagedObject {
    @NSManaged var id: NSNumber
    @NSManaged var title: String
    @NSManaged var body: String
    @NSManaged var user: User
    
    class func getAll(in context: NSManagedObjectContext) -> [Post] {
        let request = Post.fetchRequest() as! NSFetchRequest<Post>
        return (try? context.fetch(request)) ?? []
    }
    
    typealias UserId = NSNumber
    class func createOrUpdate(with array: [[String: Any]],
                              in context: NSManagedObjectContext) -> [Post] {
        return array.compactMap { self.createOrUpdate(with: $0, in: context) }
    }
    
    private class func createOrUpdate(with dictionary: [String: Any], in context: NSManagedObjectContext) -> Post? {
        guard
            let id = dictionary["id"] as? NSNumber,
            let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String,
            let userDictionary = dictionary["user"] as? [String: Any],
            let user = User.createOrUpdate(with: userDictionary, in: context) else { return nil }
        
        let request = Post.fetchRequest() as! NSFetchRequest<Post>
        request.predicate = NSPredicate(format: "id = %@", id)
        
        let post: Post
        
        do {
            if let existingPost = try context.fetch(request).first {
                post = existingPost
            } else {
                post = Post(context: context)
            }
            
            post.id = id
            post.title = title
            post.body = body
            post.user = user
            return post
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
