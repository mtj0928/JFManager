//
//  ProductEditInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductEditInteractor: ProductEditInteractorProtocol {

    private let genre: Genre
    private let dataStore: ProductStore

    init(genre: Genre, dataStore: ProductStore) {
        self.genre = genre
        self.dataStore = dataStore
    }

    func create(name: String, price: Int, image: UIImage?) {
        _ = dataStore.create(name: name, price: price, genre: genre, image: image)
    }

    func update(product: Product, name: String, price: Int, image: UIImage?) {
        if product.price != price {
            delete(product: product)
            create(name: name, price: price, image: image)
        } else {
            _ = dataStore.update(product, name: name, image: image)
        }
    }

    func delete(product: Product) {
        dataStore.delte(product)
    }
}
