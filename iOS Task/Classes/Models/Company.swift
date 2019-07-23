//
//  Company.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

class Company: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var catchPhrase: String
    @NSManaged var bs: String
    @NSManaged var user: User
}

extension Company {
    class func initialize(with dictionary: [String: Any],
                          in context: NSManagedObjectContext) -> Company? {
        guard
            let name = dictionary["name"] as? String,
            let catchPhrase = dictionary["catchPhrase"] as? String,
            let bs = dictionary["bs"] as? String else { return nil }
        
        let company = Company(context: context)
        company.name = name
        company.catchPhrase = catchPhrase
        company.bs = bs
        return company
    }
}
