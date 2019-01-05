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
    func toggle(_ purchase: Purchase)
    func liquidate(in user: User, for genre: Genre)
    func fetch() -> Results<Purchase> 
}

class PurchaseLocalStore: LocalDataStore, PurchaseStore {

    func create(_ product: Product, by user: User) -> Purchase {
        let realm = repository.build()
        let table = fetchTable()
        let purchase = Purchase()
        try! realm.write {
            purchase.id = table.purchaseId
            purchase.product = product
            user.history.append(purchase)
            user.nowPrice += product.price
            table.purchaseId += 1
        }
        return purchase
    }

    func toggle(_ purchase: Purchase) {
        if purchase.isLiquidated {
            return
        }
        let realm = repository.build()
        try! realm.write {
            purchase.user.first?.nowPrice += purchase.isCanceld ? purchase.product.price : -purchase.product.price
            purchase.isCanceld = !purchase.isCanceld
        }
    }

    func liquidate(in user: User, for genre: Genre) {
        let realm = repository.build()
        try! realm.write {
            var total = 0
            user.history
                .filter({ !$0.isLiquidated && !$0.isCanceld })
                .filter({ purchase -> Bool in
                    guard let product = purchase.product else {
                        return false
                    }
                    return product.genre == genre
                })
                .forEach({ purchase in
                    purchase.isLiquidated = true
                    total += purchase.product.price

                })
            user.nowPrice = max(user.nowPrice - total, 0)
        }
    }

    func fetch() -> Results<Purchase> {
        let realm = repository.build()
        return realm.objects(Purchase.self)
    }
}
