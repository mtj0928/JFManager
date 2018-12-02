//
//  SettingBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class SettingBuilder {

    class func defaultBuilde(_ navigationController: UINavigationController) -> UIViewController {
        let router = SettingRouter(navigationController)
        let presenter = SettingPresenter(router: router)
        let viewController = SettingViewController.createFromStoryboard()
        viewController.presenter = presenter
        return viewController
    }
}
