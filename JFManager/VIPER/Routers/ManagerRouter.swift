//
//  ManagerRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/06.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ManagerRouter: ManagerRouterProtocol {

    private weak var navigationController: UINavigationController?

    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
