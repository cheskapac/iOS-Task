//
//  UINavigationControllerExtensions.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UINavigationController {
    func blackBar() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.primary.value]
        navigationBar.tintColor = Color.primary.value
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    }
    
    func removeBackButtonTitle() {
        let barItem = UIBarButtonItem()
        barItem.title = ""
        navigationBar.topItem?.backBarButtonItem = barItem
    }
}
