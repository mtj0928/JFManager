//
//  UserEditInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserEditInteractor: UserEditInteractorProtocol {
    var positions: BehaviorRelay<[Position]> {
        return useCase.positions
    }

    private let useCase: UserUseCaseProtocol
    private let userStore: UserStore
    private let positionStore: PositionStore

    init(useCase: UserUseCaseProtocol, userStore: UserStore, positionStore: PositionStore) {
        self.useCase = useCase
        self.userStore = userStore
        self.positionStore = positionStore
    }

    func createUser(name: String, position: Position, image: UIImage?) {
        _ = userStore.create(name: name, position: position, image: image)
    }

    func createUser(name: String, position positionName: String, image: UIImage?) {
        let position = positionStore.create(name: positionName)
        createUser(name: name, position: position, image: image)
    }

    func update(_ user: User, name: String, position: Position, image: UIImage?) {
        _ = userStore.update(user: user, name: name, position: position, image: image)
    }

    func update(_ user: User, name: String, position positionText: String, image: UIImage?) {
        let position = positionStore.create(name: positionText)
        _ = userStore.update(user: user, name: name, position: position, image: image)
    }
}
