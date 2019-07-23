//
//  TextViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

struct TextViewModel: TextPresentable {
    var text: String
    var color: UIColor
    var font: UIFont
    var numberOfLines: Int
    var alignment: NSTextAlignment
    
    init(text: String,
         color: Color,
         font: Font,
         alignment: NSTextAlignment = .center,
         numberOfLines: Int = 0) {
        self.text = text
        self.color = color.value
        self.font = font.value
        self.numberOfLines = numberOfLines
        self.alignment = alignment
    }
}
