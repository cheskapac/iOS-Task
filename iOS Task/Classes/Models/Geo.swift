//
//  Geo.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

class Geo: NSManagedObject {
    @NSManaged var lat: String
    @NSManaged var lng: String
    @NSManaged var address: Address
}

extension Geo {
    class func initialize(with dictionary: [String: Any],
                          in context: NSManagedObjectContext) -> Geo? {
        guard
            let lat = dictionary["lat"] as? String,
            let lng = dictionary["lng"] as? String else { return nil }
        
        let geo = Geo(context: context)
        geo.lat = lat
        geo.lng = lng
        return geo
    }
}
