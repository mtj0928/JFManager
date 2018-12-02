//
//  UserEditViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserEditBuilder {

    static func buildDefault(user: User?) -> UIViewController {
        let repository = LocalRealmRepository()

        let userStore = UserLocalStore(repository)
        let positionStore = PositionLocalStore(repository)
        let useCase = UserUseCase(userStore: userStore, positionStore: positionStore)

        let viewControeller = UserEditViewController.createFromStoryboard()
        let interactor = UserEditInteractor(useCase: useCase, userStore: userStore, positionStore: positionStore)
        let router = UserEditRouter(viewControeller)
        let presenter = UserEditPresenter(interactor: interactor, router: router, user: user)

        viewControeller.presenter = presenter
        return viewControeller
    }
}
