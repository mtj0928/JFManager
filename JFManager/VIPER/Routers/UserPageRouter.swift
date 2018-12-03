//
//  UserPageRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserPageRouter: UserPageRouterProtocol {

    private weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func presentHistory() {
    }

    func showConfirm(user: User, product: Product) {
        let viewController = PurchaseConfirmViewBuilder.buildDefault(user: user, product: product)
        viewController.modalPresentationStyle = .formSheet
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
}
