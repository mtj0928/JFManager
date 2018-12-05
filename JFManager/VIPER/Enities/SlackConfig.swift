//
//  SlackConfig.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift


class SlackConfig: Object {
    @objc dynamic private let key = 0;
    @objc dynamic var token: String? = nil
    @objc dynamic var reportChannel: String? = nil
    @objc dynamic var drinkChannel: String? = nil
    @objc dynamic var foodChannel: String? = nil

    override class func primaryKey() -> String? {
        return "id"
    }
}
