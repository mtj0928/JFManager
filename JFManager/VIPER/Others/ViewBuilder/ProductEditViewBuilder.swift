//
//  ProductEditViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ProductEditViewBuilder {

    static func buildDefault(genre: Genre, product: Product?) -> UIViewController {
        let viewController = ProductEditViewController.createFromStoryboard()

        let dataStore = ProductLocalStore(LocalRealmRepository())
        let interactor = ProductEditInteractor(genre: genre, dataStore: dataStore)
        let router = ProductEditRouter(viewController)
        let presenter = ProductEditPresenter(interactor: interactor, router: router, product: product)

        viewController.presenter = presenter

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
