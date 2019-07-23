//
//  ButtonSize.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

enum ButtonSize {
    case large
    case medium
    case small
    case none
    
    var height: CGFloat {
        switch self {
        case .none:
            return -1
        case .large:
            return 60
        case .medium:
            return 44
        case .small:
            return 36
        }
    }
}
