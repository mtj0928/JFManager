//
//  SlackEditViewBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class SlackEditViewBuilder {

    static func buildDefault(_ navigationViewController: UINavigationController) -> UIViewController {
        let viewController = SlackEditViewController.createFromStoryboard()

        let api = SlackAPI(LocalRealmRepository())
        let dataStore = SlackConfigLocalStore(LocalRealmRepository())
        let useCase = SlackUseCase(api: api, configStore: dataStore)
        let interactor = SlackEditInteractor(useCase)

        let router = SlackEditRouter(navigationViewController)

        let presenter = SlackEditPresenter(interactor: interactor, router: router)
        viewController.presenter = presenter

        return viewController
    }
}
