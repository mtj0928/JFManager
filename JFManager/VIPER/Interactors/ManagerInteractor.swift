//
//  ManagerInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/15.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class ManagerInteractor: ManagerInteractorProtocol {
    private(set) var genre: BehaviorRelay<Genre>
    private(set) var totalPrice: BehaviorRelay<Int>
    private(set) var manager: BehaviorRelay<User?>
    var users: BehaviorRelay<[User]> {
        return userUseCase.users
    }

    private let config: SlackConfig
    private let purchases: Results<Purchase>
    private let slackUseCase: SlackUseCase
    private let userUseCase: UserUseCase
    private var notifications: [NotificationToken] = []

    init(genre: Genre, purchaseStore: PurchaseStore, userUseCase: UserUseCase, slackUseCase: SlackUseCase) {
        self.genre = BehaviorRelay(value: genre)
        self.slackUseCase = slackUseCase
        self.userUseCase = userUseCase

        totalPrice = BehaviorRelay(value: 0)
        purchases = purchaseStore.fetch()
        config = slackUseCase.fetchConfig()

        manager = BehaviorRelay(value: config.manager(genre: genre))

        notifications.append(config.observe({ [weak self] _ in
            self?.updateConfig()
        }))
        notifications.append(purchases.observe({ [weak self] _ in
            self?.updatePurchase()
        }))
    }

    private func updatePurchase() {
        let genre = self.genre.value
        let price = purchases.map({ $0 })
            .filter({ !$0.isLiquidated && !$0.isCanceld})
            .map({ $0.product! })
            .filter ({ $0.genre == genre })
            .reduce(0) { (result, product) -> Int in
                return result + product.price
        }
        self.totalPrice.accept(price)
    }

    private func updateConfig() {
        switch genre.value {
        case .drink:
            self.manager.accept(config.drinkManager)
        case .food:
            self.manager.accept(config.foodManager)
        }
    }

    deinit {
        notifications.forEach { notification in
            notification.accessibilityActivate()
        }
    }

    func sendCSV() -> Single<Void>? {
        guard let channel = slackUseCase.fetchConfig().channel(genre: genre.value) else { return nil }
        return slackUseCase.post(channel: channel, text: "")
    }

    func sendReport() -> Single<Void>? {
        guard let channel = slackUseCase.fetchConfig().reportChannel else { return nil }
        return slackUseCase.post(channel: channel, text: "")
    }

    func changeManager(user: User) {
        let config = slackUseCase.fetchConfig()
        switch genre.value {
        case .drink:
            slackUseCase.updateConfig(token: config.token, reportChannel: config.reportChannel, drinkChannel: config.drinkChannel, foodChannel: config.foodChannel, foodManager: config.foodManager, drinkManager: user)
        case .food:
            slackUseCase.updateConfig(token: config.token, reportChannel: config.reportChannel, drinkChannel: config.drinkChannel, foodChannel: config.foodChannel, foodManager: user, drinkManager: config.drinkManager)
        }
    }
}
