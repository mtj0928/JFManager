//
//  SlackUseCase.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SlackUseCaseProtocol {
    func fetchConfig() -> SlackConfig
    func updateConfig(token: String?, reportChannel: String?, drinkChannel: String?, foodChannel: String?, foodManager: User?, drinkManager: User?)
    func post(channel: String, text: String) -> Single<Void>?
}

class SlackUseCase: SlackUseCaseProtocol {

    private let configStore: SlackConfigStore
    private let api: SlackStore

    init(api: SlackStore, configStore: SlackConfigStore) {
        self.api = api
        self.configStore = configStore
    }

    func fetchConfig() -> SlackConfig {
        return configStore.fetch()
    }

    func updateConfig(token: String?, reportChannel: String?, drinkChannel: String?, foodChannel: String?, foodManager: User?, drinkManager: User?) {
        configStore.update(token: token, reportChannel: reportChannel, drinkChannel: drinkChannel, foodChannel: foodChannel, foodManager: foodManager, drinkManager: drinkManager)
    }

    func post(channel: String, text: String) -> Single<Void>? {
        guard let token = configStore.fetch().token else { return nil }

        return api.post(channel: channel, text: text, token: token)
    }
}
