//
//  ProductEditPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductEditPresenter: ProductEditPresenterProtocol {
    let productName = BehaviorRelay<String>(value: "")
    let productPrice = BehaviorRelay<Int>(value: 100)
    let productImage = BehaviorRelay<UIImage?>(value: nil)
    let shouldShowDeleteButton = BehaviorRelay<Bool>(value: false)

    private let product: Product?

    private let interactor: ProductEditInteractorProtocol
    private let router: ProductEditRouterProtocol

    init(interactor: ProductEditInteractorProtocol, router: ProductEditRouterProtocol, product: Product?) {
        self.interactor = interactor
        self.router = router
        self.product = product
        if let product = product {
            productName.accept(product.name)
            productPrice.accept(product.price)
            productImage.accept(product.image)
            shouldShowDeleteButton.accept(true)
        }
    }

    func save() {
        if let product = product {
            interactor.update(product: product, name: productName.value, price: productPrice.value, image: productImage.value)
        } else {
            interactor.create(name: productName.value, price: productPrice.value, image: productImage.value)
        }
        router.dismiss()
    }

    func delete() {
        guard let product = product else { return }

        interactor.delete(product: product)
        router.dismiss()
    }

    func cancel() {
        router.dismiss()
    }
}
