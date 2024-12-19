//
//  LoginViewController.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/19/24.
//

import UIKit

final class LoginViewController: BaseViewController<LoginReactor> {
    
    // MARK: - Properties

    var disposeBag = DisposeBag()

    // MARK: - UI

    
    // MARK: - Initializer

    init(reactor: LoginReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Setup UI

    override func addView() {
     
    }
    
    override func configure() {
       
    }
    
    override func layout() {
        
    }
    
    // MARK: - Binding

    override func bind(reactor: LoginReactor) {
        bindState(reactor: reactor)
        bindAction()
    }

    private func bindState(reactor: LoginReactor) {

    }

    private func bindAction() {

    }
}
