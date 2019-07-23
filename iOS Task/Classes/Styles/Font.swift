//
//  Font.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

enum Font {
    case heavy(CGFloat)
    case bold(CGFloat)
    case semibold(CGFloat)
    case medium(CGFloat)
    case regular(CGFloat)
    case light(CGFloat)
    
    var value: UIFont {
        switch self {
        case .heavy(let size):
            return .systemFont(ofSize: size, weight: .heavy)
        case .bold(let size):
            return .systemFont(ofSize: size, weight: .bold)
        case .semibold(let size):
            return .systemFont(ofSize: size, weight: .semibold)
        case .medium(let size):
            return .systemFont(ofSize: size, weight: .medium)
        case .regular(let size):
            return .systemFont(ofSize: size, weight: .regular)
        case .light(let size):
            return .systemFont(ofSize: size, weight: .light)
        }
    }
}
