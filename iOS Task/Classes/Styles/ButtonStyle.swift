//
//  ButtonStyle.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case clearBlack
    
    var value: (textColor: Color, font: Font, backgroundColor: Color) {
        switch self {
        case .clearBlack:
            return (textColor: .primary,
                    font: .semibold(16),
                    backgroundColor: .clear)
        }
    }
}
