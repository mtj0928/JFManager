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

    let user: BehaviorRelay<User>
    var products: BehaviorRelay<[Genre : [Product]]> {
        return interactor.products
    }

    private let interactor: UserPageInteractorProtocol
    private let router: UserPageRouterProtocol

    init(_ user: User, interactor: UserPageInteractorProtocol, router: UserPageRouterProtocol) {
        self.user = BehaviorRelay(value: user)
        self.interactor = interactor
        self.router = router
    }

    func tapBuyButton(_ product: Product) {
        interactor.buy(product)
    }

    func showHistory() {
        router.presentHistory()
    }
}
