//
//  PurchaseConfirmInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation

class PurchaseConfirmInteractor: PurchaseConfirmInteractorProtocol {

    private let purchaseStore: PurchaseStore!
    private let user: User
    private let product: Product

    init(purchaseStore: PurchaseStore, user: User, product: Product) {
        self.purchaseStore = purchaseStore
        self.user = user
        self.product = product
    }

    func purchase() {
        _ = purchaseStore.create(product, by: user)
    }
}
