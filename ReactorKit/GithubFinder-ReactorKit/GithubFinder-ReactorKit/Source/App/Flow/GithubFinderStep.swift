//
//  GithubFinderStep.swift
//  GithubFinder-ReactorKit
//
//  Created by Choi on 1/3/25.
//

import RxFlow

enum GithubFinderStep: Step {
    case tabBar
    case search
    case home
    case webView
    case profile
    case loginIsRequired
    case loginCompleted
}
