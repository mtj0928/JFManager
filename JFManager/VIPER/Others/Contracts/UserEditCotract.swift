//
//  UserEditCotracts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol UserEditPresenterProtocol {

    var name: BehaviorRelay<String> { get }
    var selectedPositionName: BehaviorRelay<String?> { get }
    var image: BehaviorRelay<UIImage?> { get }
    var positions: BehaviorRelay<[Position]> { get }

    func selectPosition(at index: Int?) 
    func saveUser()
}

protocol UserEditInteractorProtocol {

    var positions: BehaviorRelay<[Position]> { get }

    func createUser(name: String, position: Position ,image: UIImage?)
    func createUser(name: String, position: String ,image: UIImage?)

    func update(_ user: User, name: String, position: Position, image: UIImage?)
    func update(_ user: User, name: String, position: String, image: UIImage?)
}

protocol UserEditRouterProtocol {

    func dismiss()
}
