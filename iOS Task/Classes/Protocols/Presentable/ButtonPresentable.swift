//
//  ButtonPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

protocol ButtonPresentable {
    var text: String { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
    var backgroundColor: UIColor { get }
    var height: CGFloat? { get }
}
