//
//  ProductManageInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class ProductManageInteractor: ProductManageInteractorProtocol {
    let products = BehaviorRelay<[Product]>(value: [])

    private let dataStore: ProductStore
    private let productResults: Results<Product>
    private var notification: NotificationToken!

    init(dataStore: ProductStore, genre: Genre) {
        self.dataStore = dataStore
        productResults = dataStore.fetch(genre: genre).filter("isActive == %@", true)
        notification = productResults.observe({ [weak self] _ in
            guard let `self` = self else { return }
            self.products.accept(self.productResults.map { $0 })
        })
    }

    deinit {
        notification.invalidate()
    }
}
