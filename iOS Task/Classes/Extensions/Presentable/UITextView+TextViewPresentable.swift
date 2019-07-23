//
//  UITextView+TextViewPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UITextView {
    func configure(_ model: TextViewPresentable) {
        text = model.text
        font = model.font
        textColor = model.textColor
        isScrollEnabled = model.isScollEnabled
        isEditable = model.isEditable
        dataDetectorTypes = model.dataType
        
        // hardcoded
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
}
