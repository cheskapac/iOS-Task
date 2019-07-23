//
//  UIImageView+ImagePresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/30/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func configure(_ model: ImagePresentable) {
        if let imageUrl = model.url {
            var kf = self.kf
            kf.indicatorType = .activity
            kf.setImage(with: URL(string: imageUrl), options: [.transition(.fade(0.2))])
        } else if let named = model.named {
            image = UIImage(named: named)
        }
        
        contentMode = model.contentMode
    }
}
