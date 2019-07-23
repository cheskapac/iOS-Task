//
//  UITableViewExtensions.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, ofType type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ type: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: type))
    }
}
