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
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    var root: Presentable {
        return self.rootWindow
    }

    //MARK: - Initializer
    init(with window: UIWindow) {
        self.rootWindow = window
    }

    //MARK: - Flow Methods
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }
        
        switch step {
        case .tabBar:
            return coordinateToTabBarFlow()
            
        case .loginIsRequired:
            return coordinateToLoginFlow()
            
        case .loginCompleted:
            // 로그인 완료 후, (예: 모달 dismiss 또는 다시 TabBarFlow)
            return handleLoginCompleted()
            
        default:
            return .none
        }
    }

    //MARK: - Private Helpers

    /// 앱 첫 화면 분기
    func startFlow() -> FlowContributors {
        // 예: UserDefaults 또는 인증 매니저 등을 통해 로그인 상태를 판단
        let isLoggedIn = false // 임시 가정

        if isLoggedIn {
            return .one(flowContributor: .contribute(
                withNextPresentable: self,
                withNextStepper: OneStepper(withSingleStep: GithubFinderStep.tabBar)
            ))
        } else {
            return .one(flowContributor: .contribute(
                withNextPresentable: self,
                withNextStepper: OneStepper(withSingleStep: GithubFinderStep.loginIsRequired)
            ))
        }
    }

    /// TabBarFlow로 이동
    private func coordinateToTabBarFlow() -> FlowContributors {
        let tabBarFlow = TabBarFlow()

        // 탭바 플로우가 만들어지면 window.rootViewController로 설정
        Flows.use(tabBarFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
            self.rootWindow.makeKeyAndVisible()
        }

        // tabBarFlow로 진입하기 위해
        return .one(flowContributor: .contribute(
            withNextPresentable: tabBarFlow,
            withNextStepper: OneStepper(withSingleStep: GithubFinderStep.home)
        ))
    }

    /// LoginFlow로 이동 (모달 or 풀스크린 등)
    private func coordinateToLoginFlow() -> FlowContributors {
        let loginFlow = LoginFlow()

        Flows.use(loginFlow, when: .created) { [unowned self] root in
            root.modalPresentationStyle = .fullScreen
            // 현재 window의 root 위에 모달을 올리거나,
            // 혹은 rootViewController 자체를 교체할 수도 있음
            self.rootWindow.rootViewController?.present(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: loginFlow,
            withNextStepper: OneStepper(withSingleStep: GithubFinderStep.loginIsRequired)
        ))
    }

    /// 로그인 완료 처리
    private func handleLoginCompleted() -> FlowContributors {
        // 1) 로그인 모달을 닫고
        self.rootWindow.rootViewController?.dismiss(animated: true)
        // 2) 탭바로 전환
        return coordinateToTabBarFlow()
    }
}
