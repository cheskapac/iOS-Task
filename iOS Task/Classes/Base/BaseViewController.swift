//
//  BaseViewController.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/17/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift

enum StatusBarStyle {
    case light
    case dark
    case none
}

enum BackButtonStyle {
    case blank
}

enum NavigationBarStyle {
    case none
    case black
}

protocol IController: IViewModelBindable {
    var backButtonStyle: BackButtonStyle { get }
    var navigationBarStyle: NavigationBarStyle { get }
    var statusBarStyle: StatusBarStyle { get }
    var preferredStatusBarStyle: UIStatusBarStyle { get }
    var disposeBag: DisposeBag { get set }
    func setupViews()
}

extension IController {
    var backButtonStyle: BackButtonStyle { return .blank }
    var navigationBarStyle: NavigationBarStyle { return .black }
    var statusBarStyle: StatusBarStyle { return .dark }
    var hideBottomBarWhenPushed: Bool { return false }
    var shouldAutoConfigureViewModel: Bool { return false }
}

class BaseViewController<T>: UIViewController, IController {
    var disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool { return statusBarStyle == .none }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch statusBarStyle {
        case .dark:
            return UIStatusBarStyle.default
        case .light, .none:
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configure(with: viewModel)
        self.hidesBottomBarWhenPushed = self.hideBottomBarWhenPushed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
   
    func configure(with viewModel: T) {
        assertionFailure("Should override.")
    }
    
    func setupViews() {
        assertionFailure("Should override.")
    }
    
    private func setupAppearance() {
        switch backButtonStyle {
        case .blank:
            navigationController?.removeBackButtonTitle()
        }

        switch navigationBarStyle {
        case .black:
            navigationController?.blackBar()
        case .none:
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
}
