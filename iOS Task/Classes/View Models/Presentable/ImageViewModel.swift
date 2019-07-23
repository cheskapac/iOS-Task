//
//  ImageViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/30/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

struct ImageViewModel: ImagePresentable {
    var named: String?
    var url: String?
    var contentMode: UIView.ContentMode
    
    init(named: String = "placeholder_image",
         url: String? = nil,
         contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.named = named
        self.url = url
        self.contentMode = contentMode
    }
}
