//
//  DataStore.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift

class DataStore {
    let repository: RealmRepository
    
    init(_ repository: RealmRepository) {
        self.repository = repository
    }
}

class LocalDataStore: DataStore {

    func fetchTable() -> IdTable {
        let realm = repository.build()

        // すでに作成済みか確認
        let idTables = realm.objects(IdTable.self)
        if let idTable = idTables.first {
            return idTable
        }

        // 作成してなければ作成する
        let idTable = IdTable()
        try! realm.write {
            realm.add(idTable)
        }
        return idTable
    }
}
