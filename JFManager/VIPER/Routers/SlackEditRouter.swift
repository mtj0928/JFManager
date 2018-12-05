//
//  SlackEditRouter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class SlackEditRouter: SlackEditRouterProtocol {

    private weak var navigationController: UINavigationController?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func finish() {
        navigationController?.popViewController(animated: true)
    }

    func dimiss() {
        navigationController?.popViewController(animated: true)
    }
}
