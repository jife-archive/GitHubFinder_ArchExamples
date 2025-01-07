//
//  BaseViewController.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/17/24.
//

import UIKit

import PinLayout
import FlexLayout
import ReactorKit
import RxSwift
import RxCocoa
import Then

class BaseViewController<R>: UIViewController,
                             @preconcurrency ReactorKit.View where R: Reactor {
    
    typealias Reactor = R
    
    var disposeBag = DisposeBag()
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        Task { [weak self] in
            await log.verbose("DEINIT: \(String(describing: self?.className))")
        }
    }
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {}
    func configure() {}
    func addView() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await log.verbose("ViewDidLoad: \(self.className)")
        }
        self.view.backgroundColor = .white
        self.configure()
        self.addView()
    }
    
    nonisolated func bind(reactor: R) {}
}
