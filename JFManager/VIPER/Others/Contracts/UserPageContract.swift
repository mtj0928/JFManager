//
//  UserPageContracts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol UserPagePresenterProtocol {
    var user: BehaviorRelay<User> { get }
    var products: BehaviorRelay<[Genre: [Product]]> { get }
    var history: BehaviorRelay<[Purchase]> { get }

    func tapProduct(_ product: Product)
    func toggle(_ purchase: Purchase)
}

protocol UserPageInteractorProtocol {
    var user: BehaviorRelay<User> { get }
    var products: BehaviorRelay<[Genre : [Product]]> { get }
    var history: BehaviorRelay<[Purchase]> { get }
    func buy(_ product: Product)
    func toggle(_ purchase: Purchase)
}

protocol UserPageRouterProtocol {
    func showConfirm(user: User, product: Product)
}
