//
//  ManagerContracts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/06.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ManagerPresenterProtocol {
    var genre: BehaviorRelay<Genre> { get }
    var totalPrice: BehaviorRelay<Int> { get }
    var managerUser: BehaviorRelay<User?> { get }
    var users: BehaviorRelay<[User]> { get }

    func sendReport()
    func sendCSV()
    func changeManager(user: User)
}

protocol ManagerInteractorProtocol {
    var genre: BehaviorRelay<Genre> { get }
    var totalPrice: BehaviorRelay<Int> { get }
    var manager: BehaviorRelay<User?> { get }
    var users: BehaviorRelay<[User]> { get }

    func sendCSV() -> Single<Void>?
    func sendReport() -> Single<Void>?
    func changeManager(user: User)
}

protocol ManagerRouterProtocol {
    func dismiss()
}
