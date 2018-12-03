//
//  PurchaseConfirmContructs.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PurchaseConfirmPresenterProtocol {
    var user: BehaviorRelay<User> { get }
    var product: BehaviorRelay<Product> { get }

    func purchase()
    func cancel()
}

protocol PurchaseConfirmInteractorProtocol {

    func purchase()
}

protocol PurchaseConfirmRouterProtocol {
    func purchase()
    func cancel()
}
