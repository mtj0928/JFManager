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
    @objc dynamic var isActive = true
    @objc dynamic var nowPrice = 0
    let history = List<Purchase>()
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

// MARK: - Cache Logic

extension User {

    private func setImage(value: UIImage?) {
        var image = value
        var data = image?.pngData()
        while (data?.count ?? 0) > 1 * 1024 * 1024 {
            image = image?.resized(withPercentage: 0.5)
            data = image?.pngData()
        }
        imageCache = value
        imageData = data
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
