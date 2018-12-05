//
//  SlackEditInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SlackEditInteractor: SlackEditInteractorProtocol {
    let config: BehaviorRelay<SlackConfig>

    private let useCase: SlackUseCaseProtocol

    init(_ useCase: SlackUseCaseProtocol) {
        self.useCase = useCase
        config = BehaviorRelay(value: useCase.fetchConfig())
    }

    func save(token: String?, reportChannel: String?, drinkChanne: String?, foodChannel: String?) {
        useCase.updateConfig(token: token, reportChannel: reportChannel, drinkChannel: drinkChanne, foodChannel: foodChannel)
    }
}
