//
//  PurchaseConfirmPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PurchaseConfirmPresenter: PurchaseConfirmPresenterProtocol {
    let user: BehaviorRelay<User>
    let product: BehaviorRelay<Product>

    private let interactor: PurchaseConfirmInteractorProtocol
    private let router: PurchaseConfirmRouterProtocol

    init(user: User, product: Product, interactor: PurchaseConfirmInteractorProtocol, router: PurchaseConfirmRouterProtocol) {
        self.user = BehaviorRelay(value: user)
        self.product = BehaviorRelay(value: product)
        self.interactor = interactor
        self.router = router
    }

    func purchase() {
        interactor.purchase()
        router.purchase()
    }

    func cancel() {
        router.cancel()
    }
}
