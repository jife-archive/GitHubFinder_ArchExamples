//
//  AppFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/3/25.
//

import UIKit

import RxFlow
import RxSwift
import RxCocoa

final class AppFlow: Flow {
    
    //MARK: - Properties
    
    private let rootWindow: UIWindow
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var root: Presentable {
        return self.rootWindow
    }
    
    //MARK: - Initializers

    init(
        with window: UIWindow
    ) {
        self.rootWindow = window
    }
    
    deinit {
        let className = "\(type(of: self))"
        let functionName = "\(#function)"
        let message = "\(className): \(functionName)"
        Task.detached {
            await log.verbose(message)
        }
    }
}
    //MARK: - Flow Methods

extension AppFlow {
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }
        switch step {
        case .tabBar:
            return .none
        case .search:
            return .none
        case .home:
            return .none
        case .webView:
            return .none
        case .profile:
            return .none
        case .loginIsRequired:
            return .none
        case .loginCompleted:
            return .none
        }
    }
}

