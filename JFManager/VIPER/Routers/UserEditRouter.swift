//
//  UserEditRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserEditRouter: UserEditRouterProtocol {

    private let viewController: UIViewController

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
