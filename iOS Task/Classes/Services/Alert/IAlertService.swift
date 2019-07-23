//
//  IAlertService.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation

protocol IAlertService {
    func showRetryAlert(title: String?,
                        message: String?,
                        retryCallback: (() -> Void)?,
                        presentCompletion: (() -> Void)?)
}
