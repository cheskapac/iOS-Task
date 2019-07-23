//
//  BaseCoordinator.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 3/28/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import RxSwift
import Foundation

class BaseCoordinator<ResultType> {
    typealias CoordinatorResult = ResultType
    
    deinit {
        
    }
    
    let disposeBag = DisposeBag()
    
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]() {
        didSet {
            print("childCoordinators", childCoordinators.count)
        }
    }
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func release<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onDispose: { [weak self] in
                self?.release(coordinator: coordinator)
            })
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Should override this method.")
    }
}
