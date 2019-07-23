//
//  TextViewPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/31/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

protocol TextViewPresentable {
    var text: String { get }
    var font: UIFont { get }
    var textColor: UIColor { get }
    var dataType: UIDataDetectorTypes { get }
    var isEditable: Bool { get }
    var isScollEnabled: Bool { get }
}
