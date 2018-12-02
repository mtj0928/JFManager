//
//  UserEditPrsenter.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserEditPresenter: UserEditPresenterProtocol {


    let name = BehaviorRelay<String>(value: "")
    let selectedPositionName = BehaviorRelay<String?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    var positions: BehaviorRelay<[Position]> {
        return interactor.positions
    }

    private let selectPosition = BehaviorRelay<Position?>(value: nil)
    private let interactor: UserEditInteractorProtocol
    private let router: UserEditRouterProtocol
    private let user: User?

    init(interactor: UserEditInteractorProtocol, router: UserEditRouterProtocol, user: User?) {
        self.interactor = interactor
        self.router = router
        self.user = user
    }

    func selectPosition(at index: Int?) {
        if let index = index {
            let position = positions.value[index]
            selectedPositionName.accept(position.name)
            selectPosition.accept(position)
        } else {
            selectedPositionName.accept("追加")
            selectPosition.accept(nil)
        }
    }

    func saveUser() {
        if let user = user {
            update(user)
        } else {
            create()
        }
    }

    private func create() {
        if let position = selectPosition.value {
            interactor.createUser(name: name.value, position: position, image: image.value)
        } else if let position = selectedPositionName.value {
            interactor.createUser(name: name.value, position: position, image: image.value)
        }
    }

    private func update(_ user: User) {
        if let position = selectPosition.value {
            interactor.update(user, name: name.value, position: position, image: image.value)
        } else if let position = selectedPositionName.value {
            interactor.update(user, name: name.value, position: position, image: image.value)
        }
    }
}
