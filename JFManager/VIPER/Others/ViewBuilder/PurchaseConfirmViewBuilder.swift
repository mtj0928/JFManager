//
//  PurchaseConfirmViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class PurchaseConfirmViewBuilder {

    static func buildDefault(user: User, product: Product) -> UIViewController {
        let viewController = PurchaseConfirmViewController.createFromStoryboard()
        let dataStore = PurchaseLocalStore(LocalRealmRepository())
        let interactor = PurchaseConfirmInteractor(purchaseStore: dataStore, user: user, product: product)
        let router = PurchaseConfirmRouter(viewController)
        let presenter = PurchaseConfirmPresenter(user: user, product: product, interactor: interactor, router: router)

        viewController.presenter = presenter

        return viewController
    }
}
