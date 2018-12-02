//
//  MasterBuilder.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class MasterBuilder {

    static func buildDefault(_ splitViewController: UISplitViewController) -> UIViewController {
        let realmRepository = LocalRealmRepository()
        let userUseCase = UserUseCase(userStore: UserLocalStore(realmRepository), positionStore: PositionLocalStore(realmRepository))
        let interactor = MasterInteractor(userUseCase)
        let router = MasterRouter(splitViewController)
        let presenter = MasterPresenter(interactor: interactor, router: router)
        
        let viewController = MasterViewController.createFromStoryboard()
        viewController.preseter = presenter
        return viewController
    }
}
