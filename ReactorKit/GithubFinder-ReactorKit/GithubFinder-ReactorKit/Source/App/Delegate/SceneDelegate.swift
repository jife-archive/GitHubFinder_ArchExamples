//
//  SceneDelegate.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/17/24.
//

import UIKit

import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 윈도우 생성
        let window = UIWindow(windowScene: windowScene)
        
        // 루트 Flow 생성
        let appFlow = AppFlow(with: window)
        
        // 앱 실행 시, 로그인 여부 체크 (예시: UserDefaults, 토큰 존재 여부 등)
        let isLoggedIn = false // 실제 로직으로 교체
        let initialStep: GithubFinderStep = isLoggedIn ? .tabBar : .loginIsRequired

        // Flow를 등록 & 초기 스텝 지정
        Flows.use(appFlow, when: .created) { _ in }
        coordinator.coordinate(
            flow: appFlow,
            with: OneStepper(withSingleStep: initialStep)
        )
        
        // 윈도우 visible
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
