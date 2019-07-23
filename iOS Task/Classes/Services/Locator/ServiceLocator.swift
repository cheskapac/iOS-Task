//
//  ServiceLocator.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation
import CoreData

var Locator = ServiceLocator()

struct ServiceLocator {
    let coreService: ICoreDataService
    let dataService: IDataService
    let alertService: IAlertService
    
    init() {
        self.coreService = CoreDataService(persistentContainer: NSPersistentContainer(name: "CoreDataModel"))
        self.alertService = AlertService()
        self.dataService = DataService(coreService: coreService, alertService: alertService)
    }
}
