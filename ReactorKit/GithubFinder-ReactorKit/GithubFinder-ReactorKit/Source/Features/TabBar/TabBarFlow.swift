//
//  TabBarFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/13/25.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow

public final class TabBarFlow: Flow {
    public nonisolated var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController = UITabBarController()
    let steps = PublishRelay<Step>()  // 필요하다면

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }

        switch step {
        case .profile:
            self.steps.accept(GithubFinderStep.loginIsRequired)

            // 프로필 진입 시, 로그인 여부 확인
//            if !UserManager.shared.isLoggedIn {
//                // AppFlow로 .loginIsRequired 이벤트를 올림
//                self.steps.accept(GithubFinderStep.loginIsRequired)
//                return .none
//            } else {
//                // 로그인이 되어 있다면 프로필 화면으로 이동하는 로직
//                return .none
//            }
            return .none
        default:
            return .none
        }
    }
}
