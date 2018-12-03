//
//  PurchaseStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

protocol PurchaseStore {
    func create(_ product: Product, by user: User) -> Purchase
    func cancel(_ purchase: Purchase)
    func fetch() -> Results<Purchase> 
}

class PurchaseLocalStore: LocalDataStore, PurchaseStore {

    func create(_ product: Product, by user: User) -> Purchase {
        let realm = repository.build()
        let table = fetchTable()
        let purchase = Purchase()
        try! realm.write {
            purchase.id = table.productId
            purchase.product = product
            user.history.append(purchase)
            user.nowPrice += product.price
            table.purchaseId += 1
        }
        return purchase
    }

    func cancel(_ purchase: Purchase) {
        let realm = repository.build()
        try! realm.write {
            purchase.isCanceld = true
            purchase.user.first?.nowPrice -= purchase.product.price
        }
    }

    func fetch() -> Results<Purchase> {
        let realm = repository.build()
        return realm.objects(Purchase.self)
    }
}
