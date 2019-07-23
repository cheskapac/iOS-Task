//
//  UIView+Rounded.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UIView {
    func rounded() {
        clipsToBounds = true
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
}
