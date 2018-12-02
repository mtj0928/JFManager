//
//  RealmRepository.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmRepository {
    func build() -> Realm
}

class LocalRealmRepository: RealmRepository {

    func build() -> Realm {
        let realm = try! Realm()
        return realm
    }
}
