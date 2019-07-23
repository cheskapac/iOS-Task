//
//  Address.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

class Address: NSManagedObject {
    @NSManaged var street: String
    @NSManaged var suite: String
    @NSManaged var city: String
    @NSManaged var zipcode: String
    @NSManaged var geo: Geo
    @NSManaged var user: User
}

extension Address {
    class func initialize(with dictionary: [String: Any],
                          in context: NSManagedObjectContext) -> Address? {
        guard
            let street = dictionary["street"] as? String,
            let suite = dictionary["suite"] as? String,
            let city = dictionary["city"] as? String,
            let zipcode = dictionary["zipcode"] as? String,
            let geoDictionary = dictionary["geo"] as? [String: Any],
            let geo = Geo.initialize(with: geoDictionary, in: context) else { return nil }
        
        let address = Address(context: context)
        address.street = street
        address.suite = suite
        address.city = city
        address.zipcode = zipcode
        address.geo = geo
        return address
    }
}
