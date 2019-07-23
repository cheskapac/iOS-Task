//
//  AlertService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import UIKit
import RxSwift

final class AlertService: IAlertService {
    enum AlertAction {
        case action(title: String, style: UIAlertAction.Style, callback: (() -> Void)?)
        case cancel
        case ok
        
        private var value: (title: String, style: UIAlertAction.Style, callback: (() -> Void)?) {
            switch self {
            case .action(let title, let style, let callback):
                return (title, style, callback)
            case .cancel:
                return ("Cancel", .cancel, nil)
            case .ok:
                return ("OK", .default, nil)
            }
        }
        
        var title: String { return value.title }
        var style: UIAlertAction.Style { return value.style }
        var callback: (() -> Void)? { return value.callback }
    }
    
    private func showAlert(prefferedStyle: UIAlertController.Style,
                           title: String?,
                           message: String?,
                           actions: [AlertAction],
                           completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)

        actions.map { action in
            UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.callback?()
            })
        }.forEach(alertController.addAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: completion)
    }
}

extension AlertService {
    func showRetryAlert(title: String?,
                        message: String?,
                        retryCallback: (() -> Void)?,
                        presentCompletion: (() -> Void)?) {
        let actions: [AlertAction] = [
            .cancel,
            .action(title: "Retry", style: .default, callback: retryCallback)
        ]
            
        self.showAlert(prefferedStyle: .alert,
                       title: title,
                       message: message,
                       actions: actions,
                       completion: presentCompletion)
    }
}
