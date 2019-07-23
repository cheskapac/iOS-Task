//
//  ButtonViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

struct ButtonViewModel: ButtonPresentable {
    var text: String
    var textColor: UIColor
    var font: UIFont
    var backgroundColor: UIColor
    var height: CGFloat?
    
    init(text: String, style: ButtonStyle = .clearBlack, size: ButtonSize = .medium) {
        self.text = text
        self.textColor = style.value.textColor.value
        self.font = style.value.font.value
        self.backgroundColor = style.value.backgroundColor.value
        self.height = size.height
    }
}
