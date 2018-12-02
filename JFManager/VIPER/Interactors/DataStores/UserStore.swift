//
//  UserStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol UserStore {
    func create(name: String, position: Position, image: UIImage?) -> User
    func fetch() -> Results<User>
}

class UserLocalStore: LocalDataStore, UserStore {

    func create(name: String, position: Position, image: UIImage?) -> User {
        let realm = repository.build()
        let table = fetchTable()
        let user = User()

        try! realm.write {
            user.name = name
            user.position = position
            user.image = image
            user.id = table.userId
            table.userId += 1
            realm.add(user, update: true)
        }

        return user
    }

    func fetch() -> Results<User> {
        let realm = repository.build()
        return realm.objects(User.self)
    }
}
