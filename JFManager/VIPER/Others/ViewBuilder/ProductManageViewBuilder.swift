//
//  ProductManageViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ProductManageViewBuilder {

    static func buildDfault(genre: Genre, navigationController: UINavigationController) -> UIViewController {
        let viewController = ProductManageViewController.createFromStoryboard()
        let dataStore = ProductLocalStore(LocalRealmRepository())
        let interactor = ProductManageInteractor(dataStore: dataStore, genre: genre)
        let router = ProductManageRouter.init(navigationController, genre: genre)
        let presenter = ProductManagePresenter(genre: genre, interactor: interactor, router: router)
        viewController.presenter = presenter
        return viewController
    }
}
