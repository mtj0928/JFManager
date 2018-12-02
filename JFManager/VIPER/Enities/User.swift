//
//  User.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import UIKit

class User: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = "Kusumoto Lab"
    @objc dynamic var position: Position!
    var image: UIImage? {
        set { setImage(value: newValue) }
        get { return getImage() }
    }

    private var imageCache: UIImage?
    @objc dynamic private var imageData: Data?

    override class func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["image", "imageCache"]
    }
}

// - MARK: cache logic

extension User {

    private func setImage(value: UIImage?) {
        imageCache = value
        imageData = value?.pngData()
    }

    private func getImage() -> UIImage? {
        if let image = imageCache {
            return image
        } else {
            guard let data = imageData else {
                imageCache = nil
                return nil
            }
            let image = UIImage(data: data)
            self.imageCache = image
            return image
        }
    }
}
