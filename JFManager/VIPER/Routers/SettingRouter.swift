//
//  SettingRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class SettingRouter: SettingRouterProtocol {

    weak var navigationController: UINavigationController?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func presentUserManager() {
        let viewController = UserManagerBuilder.buildDefault()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func presentSlackSetting() {
        let viewController = SlackEditViewBuilder.buildDefault(navigationController)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func presentProductList(genre: Genre) {
        let viewController = ProductManageViewBuilder.buildDfault(genre: genre, navigationController: navigationController)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func presentManager(genre: Genre) {
        let viewController = ManagerViewBuilder.buildeDefault(of: genre)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
