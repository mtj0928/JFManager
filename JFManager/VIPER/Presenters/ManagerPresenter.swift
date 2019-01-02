//
//  ManagerPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/15.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ManagerPresenter: ManagerPresenterProtocol {
    var genre: BehaviorRelay<Genre> {
        return interactor.genre
    }
    var totalPrice: BehaviorRelay<Int> {
        return interactor.totalPrice
    }
    var managerUser: BehaviorRelay<User?> {
        return interactor.manager
    }
    var users: BehaviorRelay<[User]> {
        return interactor.users
    }

    private let interactor: ManagerInteractorProtocol

    init(interactor: ManagerInteractorProtocol) {
        self.interactor = interactor
    }

    func sendReport() {
        _ = interactor.sendReport()?.subscribe(onSuccess: {_ in
            // 何らかしらの更新処理
            }, onError: { _ in
                // 何かしらのエラー処理
        })
    }

    func sendCSV() {
        _ = interactor.sendCSV()?.subscribe(onSuccess: { _ in
            // 何らかしらの更新処理
            }, onError: { _ in
                // 何かしらのエラー処理
        })
    }

    func changeManager(user: User) {
        interactor.changeManager(user: user)
    }
}
