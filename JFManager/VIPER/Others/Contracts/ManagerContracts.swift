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

    func sendReport()
    func sendCSV()
}

protocol ManagerInteractorProtocol {
    func sendCSV()
    func sendReport()
}

protocol ManagerRouterProtocol {
    func dimiss()
}
