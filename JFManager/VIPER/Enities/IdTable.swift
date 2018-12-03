//
//  IdTable.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

class IdTable: Object {

    static let uniquId = 0

    @objc dynamic private let id = IdTable.uniquId
    @objc dynamic var userId = 0
    @objc dynamic var productId = 0
    @objc dynamic var purchaseId = 0
}
