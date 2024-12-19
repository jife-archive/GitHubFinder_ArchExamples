//
//  HomeViewController.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/18/24.
//

import UIKit

final class HomeViewController: BaseViewController<HomeReactor> {
    
    // MARK: - Properties
    

    // MARK: - UI
    
    private let authToggleButton = UIButton()
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Initializer

    
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

    override func bind(reactor: HomeReactor) {
        bindState(reactor: reactor)
        bindAction()
    }

    nonisolated private func bindState(reactor: HomeReactor) {

    }

    nonisolated private func bindAction() {

    }
}
