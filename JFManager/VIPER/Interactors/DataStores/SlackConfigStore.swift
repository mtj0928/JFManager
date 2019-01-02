//
//  SlackConfigStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation

protocol SlackConfigStore {

    func update(token: String?, reportChannel: String?, drinkChannel: String?, foodChannel: String?, foodManager: User?, drinkManager: User?)
    func fetch() -> SlackConfig
}

class SlackConfigLocalStore: LocalDataStore, SlackConfigStore {

    func update(token: String?, reportChannel: String?, drinkChannel: String?, foodChannel: String?, foodManager: User?, drinkManager: User?) {
        let realm = repository.build()
        let config = fetch()
        try! realm.write {
            config.token = token
            config.reportChannel = reportChannel
            config.drinkChannel = drinkChannel
            config.foodChannel = foodChannel
            config.drinkManager = drinkManager
            config.foodManager = foodManager
        }
    }

    func fetch() -> SlackConfig {
        let realm = repository.build()
        let result = realm.objects(SlackConfig.self)
        if let config = result.first {
            return config
        }
        let config = SlackConfig()
        try! realm.write {
            realm.add(config)
        }
        return config
    }
}
