//
//  ProductEditContracts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ProductEditPresenterProtocol {
    var productName: BehaviorRelay<String> { get }
    var productPrice: BehaviorRelay<Int> { get }
    var productImage: BehaviorRelay<UIImage?> { get }
    var shouldShowDeleteButton: BehaviorRelay<Bool> { get }

    func save()
    func delete()
    func cancel()
}

protocol ProductEditInteractorProtocol {
    func create(name:String, price: Int, image: UIImage?)
    func update(product: Product, name:String, price: Int, image: UIImage?)
    func delete(product: Product)
}

protocol ProductEditRouterProtocol {
    func dismiss()
}
