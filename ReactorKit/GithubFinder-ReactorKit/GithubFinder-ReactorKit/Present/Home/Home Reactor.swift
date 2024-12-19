//
//  Home Reactor.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/18/24.
//

import ReactorKit
import RxSwift

final class HomeReactor: Reactor {

    // MARK: - Properties
    
    let initialState: State = State()
    var disposeBag = DisposeBag()

    // MARK: - Action

    enum Action {

    }
    
    // MARK: - Mutation

    enum Mutation {

    }
    
    // MARK: - State

    struct State {

    }
    
    // MARK: - Mutate

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {

        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {

        }
        return newState
    }
}
