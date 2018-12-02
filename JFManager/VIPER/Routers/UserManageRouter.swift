//
//  UserManageouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

class UserManageRouter: UserManageRouterProtocol {

    private let viewController: UIViewController

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func presentUserEdit(user: User?) {
        let userEditViewController = UserEditBuilder.buildDefault(user: user)
        let toViewController =  UINavigationController(rootViewController: userEditViewController)
        toViewController.modalPresentationStyle = .formSheet

        viewController.present(toViewController, animated: true, completion: nil)
    }
}
