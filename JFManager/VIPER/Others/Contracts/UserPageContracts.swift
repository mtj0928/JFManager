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

    func tapBuyButton(_ product: Product)
    func showHistory()
}

protocol UserPageInteractorProtocol {
    var  products: BehaviorRelay<[Genre : [Product]]> { get }
    func buy(_ product: Product)
}

protocol UserPageRouterProtocol {
    func presentHistory()
}
