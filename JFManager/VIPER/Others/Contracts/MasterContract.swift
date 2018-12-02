//
//  MasterContract.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MasterPresenterProtocol {

    var users: BehaviorRelay<[Position: [User]]> { get }
    var positions: BehaviorRelay<[Position]> { get }
    var update: Observable<Void> { get }
}


protocol MasterInteractorProtocol {

    var users: BehaviorRelay<[User]> { get }
    var positions: BehaviorRelay<[Position]> { get }
}
