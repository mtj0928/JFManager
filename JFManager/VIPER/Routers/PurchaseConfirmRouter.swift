//
//  PurchaseConfirmRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class PurchaseConfirmRouter: PurchaseConfirmRouterProtocol {

    private weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func purchase() {
        viewController?.dismiss(animated: true, completion: nil)
    }

    func cancel() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
