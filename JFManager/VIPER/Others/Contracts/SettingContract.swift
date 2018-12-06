//
//  SettingContract.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SettingPresenterProtocol {
    func tapUserManagerCell()
    func tapSlackSetingCell()
    func tapProductListCell(genre: Genre)
}

protocol SettingRouterProtocol {
    func presentUserManager()
    func presentSlackSetting()
    func presentProductList(genre: Genre)
}
