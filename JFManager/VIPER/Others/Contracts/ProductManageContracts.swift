//
//  ProductManageContracts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductManagePresenterProtocol {
    var products: BehaviorRelay<[Product]> { get }
    var update: Observable<Void> { get }

    func showDetail(about product: Product)
    func addProduct()
}

protocol ProductManageInteractorProtocol {
    var products: BehaviorRelay<[Product]> { get }
}

protocol ProductManageRouterProtocol {

    func showDetail(about product: Product)
    func addProduct()
}
