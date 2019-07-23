//
//  UILabel+TextPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UILabel {
    func configure(_ model: TextPresentable) {
        text = model.text
        textColor = model.color
        font = model.font
        
        numberOfLines = model.numberOfLines
        textAlignment = model.alignment
    }
}
