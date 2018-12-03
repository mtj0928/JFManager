//
//  UserPageViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserPageViewBuilder {

    static func buildDefault(user: User) -> UserPageViewController {
        let viewController = UserPageViewController.createFromStoryboard()
        let purchaseStore = PurchaseLocalStore(LocalRealmRepository())
        let productStore = ProductLocalStore(LocalRealmRepository())

        let interactor = UserPageInteractor(user: user, purchaseStore: purchaseStore, productStore: productStore)
        let router = UserPageRouter(viewController)
        let presenter = UserPagePresenter(interactor: interactor, router: router)
        viewController.preseter = presenter

        return viewController
    }
}
