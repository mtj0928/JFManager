//
//  MasterRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class MasterRouter: MasterRouterProtocol {

    private let splitViewController: UISplitViewController
    var userPageViewController: UserPageViewController?

    init(_ splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }

    func show(user: User) {
        if userPageViewController == nil  {
            self.userPageViewController = UserPageViewBuilder.buildDefault(user: user)
        }
        userPageViewController?.set(user)
        splitViewController.showDetailViewController(userPageViewController!, sender: self)
    }

    func showSetting() {
        let navigationController = UINavigationController()
        let viewController = SettingBuilder.defaultBuilde(navigationController)
        navigationController.viewControllers = [viewController]
        viewController.view.backgroundColor = UIColor.white
        splitViewController.showDetailViewController(navigationController, sender: self)
    }
}
