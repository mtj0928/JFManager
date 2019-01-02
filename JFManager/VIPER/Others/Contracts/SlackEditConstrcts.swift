//
//  SlackEditConstrcts.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SlackEditPresenterProtocol {
    var token: BehaviorRelay<String?> { get }
    var reportChannel: BehaviorRelay<String?> { get }
    var drinkChannel: BehaviorRelay<String?> { get }
    var foodChannel: BehaviorRelay<String?> { get }

    func save()
    func dismiss()
}

protocol SlackEditInteractorProtocol {
    var config: BehaviorRelay<SlackConfig> { get }

    func save(token: String?, reportChannel: String?, drinkChannel: String?, foodChannel: String?)
}

protocol SlackEditRouterProtocol {
    func finish()
    func dimiss()
}
