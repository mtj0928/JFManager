//
//  ProductManagePresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductManagePresenter: ProductManagePresenterProtocol {
    var products: BehaviorRelay<[Product]> {
        return interactor.products
    }
    private(set) lazy var update: Observable<Void> = products.map({_ in })

    private let interactor: ProductManageInteractorProtocol
    private let router: ProductManageRouterProtocol

    private let genre: Genre

    init(genre: Genre, interactor: ProductManageInteractorProtocol, router: ProductManageRouterProtocol) {
        self.genre = genre
        self.interactor = interactor
        self.router = router
    }

    func showDetail(about product: Product) {
        router.showDetail(about: product)
    }

    func addProduct() {
        router.addProduct()
    }
}
