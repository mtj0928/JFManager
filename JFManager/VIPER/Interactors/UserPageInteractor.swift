//
//  UserPageInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class UserPageInteractor: UserPageInteractorProtocol {

    let products = BehaviorRelay<[Genre : [Product]]>(value: [:])

    private let user: User
    private let purchaseStore: PurchaseStore
    private let productStore: ProductStore

    init(user: User, purchaseStore: PurchaseStore, productStore: ProductStore) {
        self.user = user
        self.purchaseStore = purchaseStore
        self.productStore = productStore

        products.accept([
            .drink: getArray(genre: .drink),
            .food: getArray(genre: .food)
            ])
    }

    private func getArray(genre: Genre) -> [Product] {
        return productStore.fetch(genre: genre)
            .filter("isActive == %@", true)
            .map({ $0 })
    }

    func buy(_ product: Product) {
        _ = purchaseStore.create(product, by: user)
    }
}
