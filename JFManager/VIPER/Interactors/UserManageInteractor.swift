//
//  SettingInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

class UserManageInteractor: UserManageInteractorProtocol {

    var users: BehaviorRelay<[User]> {
        return userUseCase.users
    }
    var positions: BehaviorRelay<[Position]> {
        return userUseCase.positions
    }

    private let userUseCase: UserUseCaseProtocol
    private let userStore: UserStore
    private let positionStore: PositionStore

    init(userUseCase: UserUseCaseProtocol, userStore: UserStore, positionStore: PositionStore) {
        self.userUseCase = userUseCase
        self.userStore = userStore
        self.positionStore = positionStore
    }

    func createUser(name: String, position: Position, image: UIImage?) {
        _ = userStore.create(name: name, position: position, image: image)
    }

    func createUser(name: String, position positionaName: String, image: UIImage?) {
        let position = positionStore.create(name: positionaName)
        createUser(name: name, position: position, image: image)
    }
}
