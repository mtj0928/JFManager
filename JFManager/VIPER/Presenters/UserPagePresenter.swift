//
//  UserPagePresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserPagePresenter: UserPagePresenterProtocol {

    var user: BehaviorRelay<User> {
        return interactor.user
    }
    var products: BehaviorRelay<[Genre : [Product]]> {
        return interactor.products
    }
    var history: BehaviorRelay<[Purchase]> {
        return interactor.history
    }

    private let interactor: UserPageInteractorProtocol
    private let router: UserPageRouterProtocol

    init(interactor: UserPageInteractorProtocol, router: UserPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func tapProduct(_ product: Product) {
        router.showConfirm(user: user.value, product: product)
    }

    func toggle(_ purchase: Purchase) {
        interactor.toggle(purchase)
    }
}
