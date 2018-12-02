//
//  Position.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

final class Position: Object {

    @objc dynamic var name = "M1"
    var order = 0

    override class func primaryKey() -> String? {
        return "name"
    }

    override class func ignoredProperties() -> [String] {
        return []
    }
}
