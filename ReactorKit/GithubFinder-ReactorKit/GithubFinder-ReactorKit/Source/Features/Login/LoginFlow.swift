//
//  LoginFlow.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/3/25.
//

import RxFlow
import RxCocoa
import RxSwift
import UIKit

final class LoginFlow: Flow {

    // MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init() {}

    deinit {
        print("\(type(of: self)): deinit")
    }
    
    // MARK: - Flow
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? GithubFinderStep else { return .none }
        switch step {
        case .loginIsRequired:
            return navigateToLoginScreen()
            
        case .loginCompleted:
            return .end(forwardToParentFlowWithStep: GithubFinderStep.loginCompleted)
            
        default:
            return .none
        }
    }
}

private extension LoginFlow {
    func navigateToLoginScreen() -> FlowContributors {
        let reactor = LoginReactor() // ReactorKit 사용 시
        let loginVC = LoginViewController(reactor: reactor)
        
        // 로그인 뷰를 네비게이션 root로 설정
        self.rootViewController.setViewControllers([loginVC], animated: false)
        
        // 다음 프레젠터로 `self`(LoginFlow)와,
        // 다음 스테퍼로는 reactor 또는 OneStepper 등을 설정
        return .one(flowContributor: .contribute(
            withNextPresentable: self,
            withNextStepper: reactor as! Stepper
        ))
    }
}
