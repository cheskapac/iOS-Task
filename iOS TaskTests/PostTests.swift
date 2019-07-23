//
//  PostTests.swift
//  iOS TaskTests
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import XCTest
import CoreData

class PostTests: XCTestCase {
    var coreService: ICoreDataService!
    
    override func setUp() {
        self.coreService = MockCoreDataService(persistentContainer: self.mockPersistantContainer)
    }
    
    func test_PostModelInit() {
        let post = self.coreService.createOrUpdatePosts(with: [MockData.postCombinedDictionary]).first
        XCTAssertNotNil(post)
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataModel", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}

class PostTests2: XCTestCase {
    func test_CombinedDictionaries() {
        var combinedDictionaries = [[String: Any]]()
        
        [MockData.postDictionary].forEach {
            var mutablePost = $0
            if let userId = $0["userId"] as? NSNumber {
                if let userDictionary = [MockData.userDictionary].first(where: { ($0["id"] as? NSNumber) == userId }) {
                    mutablePost["user"] = userDictionary
                }
                
                combinedDictionaries.append(mutablePost)
            }
        }
        
        
        XCTAssertNotNil(combinedDictionaries.first)
        
        let combinedDict = NSDictionary(dictionary: combinedDictionaries.first!)
        XCTAssertTrue(combinedDict.isEqual(to: MockData.postCombinedDictionary))
    }
}
