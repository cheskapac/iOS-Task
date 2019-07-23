//
//  UINavigationItem+Spinner.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/27/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func showLoadingSpinner(style: UIActivityIndicatorView.Style = .gray) {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        let item = UIBarButtonItem(customView: activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        if self.rightBarButtonItem == nil {
            self.rightBarButtonItem = item
        } else {
            self.rightBarButtonItems?.insert(item, at: 0)
        }
    }
    
    func removeLoadingSpinner() {
        guard let items = rightBarButtonItems else { return }
        
        for (i, item) in items.enumerated() {
            if let indicator = item.customView as? UIActivityIndicatorView {
                indicator.stopAnimating()
                rightBarButtonItems?.remove(at: i)
                break
            }
        }
    }
}
