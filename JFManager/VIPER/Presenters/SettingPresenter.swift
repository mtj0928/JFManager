//
//  SettingPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation

class SettingPresenter: SettingPresenterProtocol {

    private let router: SettingRouterProtocol

    init(router: SettingRouterProtocol) {
        self.router = router
    }

    func tapUserManagerCell() {
        router.presentUserManager()
    }

    func tapSlackSetingCell() {
        router.presentSlackSetting()
    }

    func tapProductListCell(genre: Genre) {
        router.presentProductList(genre: genre)
    }

    func tapManager(genre: Genre) {
        router.presentManager(genre: genre)
    }
}
