//
//  TextPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

protocol TextPresentable {
    var text: String { get }
    var color: UIColor { get }
    var font: UIFont { get }
    var numberOfLines: Int { get }
    var alignment: NSTextAlignment { get }
}
