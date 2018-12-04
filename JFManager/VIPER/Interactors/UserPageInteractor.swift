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

    let user: BehaviorRelay<User>
    let products = BehaviorRelay<[Genre : [Product]]>(value: [:])
    let history = BehaviorRelay<[Purchase]>(value: [])

    private let purchaseStore: PurchaseStore
    private let productStore: ProductStore

    private var historyResults: Results<Purchase>!
    private var historyNotification: NotificationToken?

    private var productResults: Results<Product>!
    private var productNotification: NotificationToken?

    private var disposeBag = DisposeBag()

    init(user: User, purchaseStore: PurchaseStore, productStore: ProductStore) {
        self.user = BehaviorRelay(value: user)
        self.purchaseStore = purchaseStore
        self.productStore = productStore

        updateHistory()
        updateProduct()

        self.user.subscribe(onNext: { [weak self] user in
            self?.updateHistory()
        }).disposed(by: disposeBag)
    }

    private func updateHistory() {
        historyNotification?.invalidate()
        historyResults = user.value.history.sorted(byKeyPath: "date", ascending: false)

        history.accept(historyResults.map({ $0 }))

        historyNotification = historyResults.observe { [weak self] _ in
            guard let `self` = self else { return }
            self.history.accept(self.historyResults.map({ $0 }))
        }
    }

    private func updateProduct() {
        productNotification?.invalidate()
        productResults = productStore.fetch().filter("isActive == %@", true)

        products.accept([
            .drink: getArray(genre: .drink),
            .food: getArray(genre: .food)
            ])

        productNotification = productResults._observe({ [weak self] _ in
            guard let `self` = self else { return }
            self.products.accept([
                .drink: self.getArray(genre: .drink),
                .food: self.getArray(genre: .food)
                ])
        })
    }

    deinit {
        historyNotification?.invalidate()
        productNotification?.invalidate()
    }

    private func getArray(genre: Genre) -> [Product] {
        return productStore.fetch(genre: genre)
            .filter("isActive == %@", true)
            .sorted(byKeyPath: "price", ascending: false)
            .map({ $0 })
    }

    func buy(_ product: Product) {
        _ = purchaseStore.create(product, by: user.value)
    }

    func toggle(_ purchase: Purchase) {
        purchaseStore.toggle(purchase)
    }
}
