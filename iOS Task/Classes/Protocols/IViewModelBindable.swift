//
//  IViewModelBindable.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/25/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation

protocol IViewModelBindable: class {
    associatedtype T
    var viewModel: T { get set }
    func configure(with viewModel: T)
    func reConfigure()
    var shouldAutoConfigureViewModel: Bool { get }
}

extension IViewModelBindable {
    var shouldAutoConfigureViewModel: Bool { return true }
    
    var viewModel: T {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKey.viewModel) as! T
        }
        
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &AssociatedObjectKey.viewModel,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            if shouldAutoConfigureViewModel {
                configure(with: newValue)
            }
        }
    }
    
    func reConfigure() {
        configure(with: viewModel)
    }
}

private struct AssociatedObjectKey {
    static var viewModel = "viewModel"
}
