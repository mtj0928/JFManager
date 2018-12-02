//
//  UserManagerBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserManagerBuilder {

    static func buildDefault() -> UIViewController {
        let repository = LocalRealmRepository()

        let userStore = UserLocalStore(repository)
        let positionStore = PositionLocalStore(repository)
        let userUserCase = UserUseCase(userStore: userStore, positionStore: positionStore)

        let viewController = UserManageViewController.createFromStoryboard()
        let interatcor = UserManageInteractor.init(userUseCase: userUserCase, userStore: userStore, positionStore: positionStore)
        let router = UserManageRouter(viewController)
        let presenter = UserManagePresenter(interactor: interatcor, router: router)

        viewController.presenter = presenter
        return viewController
    }
}
