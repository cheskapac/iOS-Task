//
//  User.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
    @NSManaged var phone: String
    @NSManaged var website: String
    @NSManaged var posts: NSSet
    @NSManaged var company: Company
    @NSManaged var address: Address
    
    var photoUrl: String {
        return "https://source.unsplash.com/collection/542909/?sig=\(id)"
    }
}

extension User {
    typealias UserId = NSNumber
    
    class func createOrUpdate(with dictionary: [String: Any], in context: NSManagedObjectContext) -> User? {
        guard
            let id = dictionary["id"] as? NSNumber,
            let name = dictionary["name"] as? String,
            let username = dictionary["username"] as? String,
            let email = dictionary["email"] as? String,
            let phone = dictionary["phone"] as? String,
            let website = dictionary["website"] as? String,
            let addressDictionary = dictionary["address"] as? [String: Any],
            let address = Address.initialize(with: addressDictionary, in: context),
            let companyDictionary = dictionary["company"] as? [String: Any],
            let company = Company.initialize(with: companyDictionary, in: context) else { return nil }
        
        let request = User.fetchRequest() as! NSFetchRequest<User>
        request.predicate = NSPredicate(format: "id = %d", id)
        
        let user: User
        
        do {
            if let existingUser = try context.fetch(request).first {
                user = existingUser
            } else {
                user = User(context: context)
            }
            
            user.id = id
            user.name = name
            user.username = username
            user.email = email
            user.phone = phone
            user.website = website
            user.company = company
            user.address = address
            return user
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
