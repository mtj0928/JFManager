//
//  UserUseCase.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol UserUseCaseProtocol {
    var users: BehaviorRelay<[User]> { get }
    var positions: BehaviorRelay<[Position]> { get }
}

class UserUseCase: UserUseCaseProtocol {
    let users = BehaviorRelay<[User]>(value: [])
    let positions = BehaviorRelay<[Position]>(value: [])

    private let userResults: Results<User>
    private let positionResults: Results<Position>
    private var notifications: [NotificationToken] = []

    private let userStore: UserStore
    private let positionStore: PositionStore

    init(userStore: UserStore, positionStore: PositionStore) {
        self.userStore = userStore
        self.positionStore = positionStore

        self.userResults = userStore.fetch()
        self.positionResults = positionStore.fetch()

        notifications.append(userResults.observe { [weak self] _ in
            guard let `self` = self else { return }
            self.users.accept(self.userResults.map { $0 })
        })

        notifications.append(positionResults.observe({ [weak self] _ in
            guard let `self` = self else { return }
            self.positions.accept(self.positionResults.map { $0 })
        }))
    }

    deinit {
        notifications.forEach { notification in
            notification.invalidate()
        }
    }
}
