//
//  AppCoordinator.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/20/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var delegate: CoordinatorDelegate?
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    
    func start() {

    }
}
