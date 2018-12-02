//
//  ProductManageRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ProductManageRouter: ProductManageRouterProtocol {

    private let navigationController: UINavigationController
    private let genre: Genre

    init(_ navigationController: UINavigationController, genre: Genre) {
        self.navigationController = navigationController
        self.genre = genre
    }

    func showDetail(about product: Product) {
        let viewController = ProductEditViewBuilder.buildDefault(genre: genre, product: product)
        viewController.modalPresentationStyle = .formSheet
        navigationController.present(viewController, animated: true, completion: nil)
    }

    func addProduct() {
        let viewController = ProductEditViewBuilder.buildDefault(genre: genre, product: nil)
        viewController.modalPresentationStyle = .formSheet
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
