//
//  ImagePresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/30/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

protocol ImagePresentable {
    var url: String? { get }
    var named: String? { get }
    var contentMode: UIView.ContentMode { get }
}
