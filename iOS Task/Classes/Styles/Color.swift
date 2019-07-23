//
//  Color.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

enum Color {
    case primary
    case secondary
    case clear
    
    var value: UIColor {
        switch self {
        case .primary:
            return .black
        case .secondary:
            return .blue
        case .clear:
            return .clear
        }
    }
}
