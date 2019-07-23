//
//  TextViewViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

struct TextViewViewModel: TextViewPresentable {
    var text: String
    var font: UIFont
    var textColor: UIColor
    var isEditable: Bool
    var isScollEnabled: Bool
    var dataType: UIDataDetectorTypes
    
    init(text: String,
         textColor: Color,
         font: Font,
         dataType: UIDataDetectorTypes,
         isEditable: Bool = false,
         isScollEnabled: Bool = false) {
        self.text = text
        self.font = font.value
        self.textColor = textColor.value
        self.dataType = dataType
        self.isScollEnabled = isScollEnabled
        self.isEditable = isEditable
    }
}
