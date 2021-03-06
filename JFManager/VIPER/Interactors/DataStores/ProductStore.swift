//
//  ProductStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol ProductStore {

    func create(name: String, price: Int, genre: Genre, image: UIImage?) -> Product
    func update(_ product: Product, name: String, image: UIImage?) -> Product
    func fetch() ->  Results<Product>
    func fetch(genre: Genre) ->  Results<Product>
    func delte(_ product: Product) 
}

class ProductLocalStore: LocalDataStore, ProductStore {

    func create(name: String, price: Int, genre: Genre, image: UIImage?) -> Product {
        let realm = repository.build()
        let idTable = fetchTable()
        let product = Product()
        try! realm.write {
            product.id = idTable.productId
            product.name = name
            product.genre = genre
            product.price = price
            product.image = image

            idTable.productId += 1
            realm.add(product)
        }
        return product
    }

    func update(_ product: Product, name: String, image: UIImage?) -> Product {
        let realm = repository.build()
        try! realm.write {
            product.name = name
            product.image = image
        }
        return product
    }

    func fetch() -> Results<Product> {
        let realm = repository.build()
        return realm.objects(Product.self)
    }

    func fetch(genre: Genre) -> Results<Product> {
        let realm = repository.build()
        let results = realm.objects(Product.self)
            .filter("_genre == %@", genre.rawValue)
        return results
    }

    func delte(_ product: Product) {
        let realm = repository.build()
        try! realm.write {
            product.isActive = false
        }
    }
}
