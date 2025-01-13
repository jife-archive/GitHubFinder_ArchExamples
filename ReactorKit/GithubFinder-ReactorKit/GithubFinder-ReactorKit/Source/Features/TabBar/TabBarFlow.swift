//
//  TabBarFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/13/25.
//

import UIKit

import RxSwift
import RxFlow

@MainActor
public final class TabBarFlow: Flow {
    public nonisolated var root: any RxFlow.Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    
    public nonisolated func navigate(to step: any RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }
        switch step {
            default:
                return .none
        }
    }
}
extension TabBarFlow {
    

}
