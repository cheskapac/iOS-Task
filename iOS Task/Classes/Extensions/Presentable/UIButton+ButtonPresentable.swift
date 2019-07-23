//
//  UIButton+ButtonPresentable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit

extension UIButton {
    func configure(_ model: ButtonPresentable) {
        titleLabel?.font = model.font
    
        setTitle(model.text, for: .normal)
        setTitleColor(model.textColor, for: .normal)
        setTitleColor(model.textColor.withAlphaComponent(0.8), for: .highlighted)
        setTitleColor(model.textColor.withAlphaComponent(0.2), for: .disabled)
        
        setBackground(color: model.backgroundColor, forState: .normal)
        let highlightedStateColor = model.backgroundColor != .clear ? model.backgroundColor.withAlphaComponent(0.8) : .clear
        setBackground(color: highlightedStateColor, forState: .highlighted)
        setBackground(color: model.backgroundColor.withAlphaComponent(0.2), forState: .disabled)
        
        adjustsImageWhenHighlighted = false
        
        let heightIdentifier = "heightConstraint"
        if let height = model.height {
            for constraint in constraints where constraint.identifier == heightIdentifier {
                constraint.isActive = false
                break
            }
            
            if height > 0 {
                let heightConstraint = heightAnchor.constraint(equalToConstant: height)
                heightConstraint.identifier = heightIdentifier
                heightConstraint.isActive = true
            }
        }
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

extension UIButton {
    private func setBackground(color: UIColor, forState state: UIControl.State) {
        if color == .clear {
            backgroundColor = color
            setBackgroundImage(nil, for: state)
            return
        }
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: state)
    }
}
