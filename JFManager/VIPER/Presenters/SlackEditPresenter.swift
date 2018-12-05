//
//  SlackEditPresenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SlackEditPresenter: SlackEditPresenterProtocol {
    let token: BehaviorRelay<String?>
    let reportChannel: BehaviorRelay<String?>
    let drinkChannel: BehaviorRelay<String?>
    let foodChannel: BehaviorRelay<String?>

    private let interactor: SlackEditInteractorProtocol
    private let router: SlackEditRouterProtocol

    init(interactor: SlackEditInteractorProtocol, router: SlackEditRouterProtocol) {
        self.interactor = interactor
        self.router = router

        let config = interactor.config.value
        self.token = BehaviorRelay(value: config.token)
        self.reportChannel = BehaviorRelay(value: config.reportChannel)
        self.drinkChannel = BehaviorRelay(value: config.drinkChannel)
        self.foodChannel = BehaviorRelay(value: config.foodChannel)
    }

    func save() {
        interactor.save(token: token.value, reportChannel: reportChannel.value, drinkChanne: drinkChannel.value, foodChannel: foodChannel.value)
        router.finish()
    }

    func dismiss() {
        router.dimiss()
    }
}
