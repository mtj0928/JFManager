//
//  MasterInteractor.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class MasterInteractor: MasterInteractorProtocol {
    var users: BehaviorRelay<[User]> {
        return userUseCase.users
    }
    var positions: BehaviorRelay<[Position]> {
        return userUseCase.positions
    }

    private let userUseCase: UserUseCaseProtocol

    init(_ userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
}
