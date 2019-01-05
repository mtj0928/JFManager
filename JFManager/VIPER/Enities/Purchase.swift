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

    func shouldBeLiquidate() -> Bool {
        // 清算されていない && 取り消されていない
        return !isLiquidated && !isCanceld
    }

    func shouldBeLiquidate(genre: Genre) -> Bool {
        guard let product = product else {
            return false
        }
        // 指定したジャンル
        guard product.genre == genre else {
            return false
        }
        // 清算されていない && 取り消されていない
        return !isLiquidated && !isCanceld
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
