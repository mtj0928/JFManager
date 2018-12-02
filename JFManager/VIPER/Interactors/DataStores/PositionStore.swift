//
//  PositionStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol PositionStore {
    func create(name: String) -> Position
    func fetch() -> Results<Position>
}

class PositionLocalStore: LocalDataStore, PositionStore {

    func create(name: String) -> Position {
        let realm = repository.build()
        let position = Position()
        try! realm.write {
            position.name = name
            realm.add(position)
        }
        return position
    }

    func fetch() -> Results<Position> {
        let realm = repository.build()
        return realm.objects(Position.self)
    }
}
