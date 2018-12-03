//
//  Purchase.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

class Purchase: Object {

    @objc dynamic var id = 0
    @objc private(set) dynamic var date = Date()
    @objc dynamic var product: Product! = nil
    @objc dynamic var isLiquidated = false
    @objc dynamic var isCanceld = false
    let user = LinkingObjects(fromType: User.self, property: "history")


    override class func primaryKey() -> String? {
        return "id"
    }
}
