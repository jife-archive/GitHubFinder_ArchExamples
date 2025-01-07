//
//  AppFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/3/25.
//

import UIKit

import RxFlow

final class AppFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController: TabBarViewController

    init() {
        self.rootViewController = TabBarViewController()
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }

        switch step {
        case .tabBar:
            <#code#>
        case .search:
            <#code#>
        case .home:
            <#code#>
        case .webView:
            <#code#>
        case .profileIsRequired:
            <#code#>
        case .loginIsRequired:
            <#code#>
        }
    }

    private func setupTabBar() -> FlowContributors {
        let homeFlow = HomeFlow()

        Flows.use(searchFlow, profileFlow, when: .created) { [weak self] (searchRoot, profileRoot) in
            let searchTab = UITabBarItem(title: "Search",
                                         image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
            searchRoot.tabBarItem = searchTab

            let profileTab = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person.circle"), selectedImage: nil)
            profileRoot.tabBarItem = profileTab

            self?.rootViewController.setViewControllers([searchRoot, profileRoot], animated: false)
        }

        return .multiple(flowContributors: [
            .contribute(withNext: searchFlow),
            .contribute(withNext: profileFlow)
        ])
    }
}
