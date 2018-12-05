//
//  SlackStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import SKWebAPI

protocol SlackStore {
    func post(channel: String, text: String, token: String) -> Single<Void>
}

class SlackAPI: DataStore, SlackStore {

    func post(channel: String, text: String, token: String) -> Single<Void> {
        return Single.create(subscribe: { observer -> Disposable in
            let webAPI = WebAPI(token: token)

            webAPI.sendMessage(channel: channel, text: text, success: { (ts, channel) in
                observer(.success(Void()))
            }) { error in
                observer(.error(error))
            }
            return Disposables.create()
        })
    }
}
