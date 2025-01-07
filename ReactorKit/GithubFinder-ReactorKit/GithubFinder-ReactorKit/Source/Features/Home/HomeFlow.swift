//
//  HomeFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/3/25.
//

import UIKit
import RxFlow

public final class HomeFlow: Flow {
    // `root` 프로퍼티
    public var root: Presentable {
        return rootViewController
    }

    // Root Navigation Controller
    private let rootViewController: UINavigationController

    public init() {
        // MainActor에서 Navigation Controller 초기화
        self.rootViewController = UINavigationController()
    }


    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }

        switch step {
        case .home:
            return navigateToHome()
        default:
            return .none
        }
    }

    private func navigateToHome() -> FlowContributors {
        // 메인 스레드에서 ViewController 설정
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            self.rootViewController.setViewControllers([homeViewController], animated: false)
        }
        return .one(flowContributor: .contribute(withNextPresentable: self.rootViewController, withNextStepper: OneStepper(withSingleStep: GithubFinderStep.home)))
    }
}
