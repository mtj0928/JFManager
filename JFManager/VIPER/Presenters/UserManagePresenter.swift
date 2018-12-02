//
//  UserManagePresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserManagePresenter: UserManagePresenterProtocol {

    let users = BehaviorRelay<[Position: [User]]>(value: [:])
    var positions: BehaviorRelay<[Position]> {
        return interactor.positions
    }
    private(set) lazy var update = Observable.combineLatest(users, positions) { (_, _) in }

    private let interactor: UserManageInteractorProtocol
    private let router: UserManageRouterProtocol
    private let disposeBag = DisposeBag()

    init(interactor: UserManageInteractorProtocol, router: UserManageRouterProtocol) {
        self.interactor = interactor
        self.router = router

        interactor.users.subscribe(onNext: { [weak self] users in
            self?.users.accept(Dictionary(grouping: users, by: { $0.position! }))
        }).disposed(by: disposeBag)
    }

    func tapAddUser() {
        router.presentUserEdit(user: nil)
    }
}
