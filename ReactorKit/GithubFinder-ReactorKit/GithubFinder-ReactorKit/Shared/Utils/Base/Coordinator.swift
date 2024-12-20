//
//  Coordinator.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/20/24.
//

import UIKit

// 기본 Coordinator Protocol
protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: any Coordinator)
}
protocol Coordinator: AnyObject {
    
    var childCoordinators: [any Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var delegate: CoordinatorDelegate? { get set }
    
    func start()
    func finish()
}
extension Coordinator {
    
    /// 네비게이션 스택 지우는 코디네이터
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }
    
    @MainActor func dismiss(animated: Bool = false) {
        navigationController.presentedViewController?.dismiss(animated: animated)
    }
    
    @MainActor func popupViewController(animated: Bool = false) {
        navigationController.popViewController(animated: animated)
    }
}
