//
//  ManagerViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/06.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ManagerViewBuilder {

    static func buildeDefault(of genre: Genre) -> UIViewController {
        let viewController = ManagerViewController.createFromStoryboard()

        let repository = LocalRealmRepository()
        let purchaseStore = PurchaseLocalStore(repository)
        let userStore = UserLocalStore(repository)
        let positionStore = PositionLocalStore(repository)
        let userUseCase = UserUseCase(userStore: userStore, positionStore: positionStore)
        let slackApi = SlackAPI(repository)
        let slackConfigStore = SlackConfigLocalStore(repository)
        let slackUseCase = SlackUseCase(api: slackApi, configStore: slackConfigStore)
        let interactor = ManagerInteractor(genre: genre, purchaseStore: purchaseStore, userUseCase: userUseCase, slackUseCase: slackUseCase)

        let presenter = ManagerPresenter(interactor: interactor)

        viewController.presenter = presenter
        
        return viewController
    }
}

