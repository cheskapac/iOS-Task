//
//  UIApplication+TopController.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(_ baseViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = baseViewController as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        
        if let tabBarViewController = baseViewController as? UITabBarController {
            
            let moreNavigationController = tabBarViewController.moreNavigationController
            
            if let topTopViewController = moreNavigationController.topViewController, topTopViewController.view.window != nil {
                return topViewController(topTopViewController)
            } else if let selectedViewController = tabBarViewController.selectedViewController {
                return topViewController(selectedViewController)
            }
        }
        
        if let splitViewController = baseViewController as? UISplitViewController, splitViewController.viewControllers.count == 1 {
            return topViewController(splitViewController.viewControllers[0])
        }
        
        if let presentedViewController = baseViewController?.presentedViewController {
            return topViewController(presentedViewController)
        }
        
        return baseViewController
    }
}
