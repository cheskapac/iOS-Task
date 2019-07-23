//
//  AppDelegate.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/17/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!)
        
        Locator.coreService.loadPersistentContainer {
            self.appCoordinator?.start().take(1).subscribe().dispose()
        }
        
        return true
    }
}
