//
//  MasterPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MasterPresenter: MasterPresenterProtocol {

    let users = BehaviorRelay<[Position: [User]]>(value: [:])
    var positions: BehaviorRelay<[Position]> {
        return interactor.positions
    }
    private(set) lazy var update = Observable.combineLatest(users, positions) { (_, _) in }

    private let interactor: MasterInteractorProtocol
    private let router: MasterRouterProtocol
    private let disposeBag = DisposeBag()

    init(interactor: MasterInteractorProtocol, router: MasterRouterProtocol) {
        self.interactor = interactor
        self.router = router

        interactor.users.subscribe(onNext: { [weak self] users in
            self?.users.accept(Dictionary(grouping: users, by: { $0.position! }))
        }).disposed(by: disposeBag)
    }

    func show(user: User) {
        router.show(user: user)
    }

    func showSetting() {
        router.showSetting()
    }
}
