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
    private var notification: NotificationToken?
    private var disposeBag = DisposeBag()

    init(user: User, purchaseStore: PurchaseStore, productStore: ProductStore) {
        self.user = BehaviorRelay(value: user)
        self.purchaseStore = purchaseStore
        self.productStore = productStore

        update()

        self.user.subscribe(onNext: { [weak self] user in
            self?.update()
        }).disposed(by: disposeBag)

        products.accept([
            .drink: getArray(genre: .drink),
            .food: getArray(genre: .food)
            ])
    }

    private func update() {
        notification?.invalidate()
        historyResults = user.value.history.sorted(byKeyPath: "date", ascending: false)

        history.accept(historyResults.map({ $0 }))

        notification = historyResults.observe { [weak self](_) in
            guard let `self` = self else { return }
            self.history.accept(self.historyResults.map({ $0 }))
        }
    }

    deinit {
        notification?.invalidate()
    }

    private func getArray(genre: Genre) -> [Product] {
        return productStore.fetch(genre: genre)
            .filter("isActive == %@", true)
            .map({ $0 })
    }

    func buy(_ product: Product) {
        _ = purchaseStore.create(product, by: user.value)
    }
}
