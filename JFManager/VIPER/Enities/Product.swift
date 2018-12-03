//
//  Product.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

enum Genre: String {
    case food, drink

    var japanese: String {
        switch self {
        case .drink:
            return "ジュース会"
        case .food:
            return "食品会"
        }
    }
}

class Product: Object {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var price = 0
    @objc dynamic var isActive = true
    @objc dynamic private var _genre = "food"
    var genre: Genre {
        get {
            return Genre(rawValue: _genre)!
        }
        set {
            _genre = newValue.rawValue
        }
    }
    @objc dynamic private var imageData: Data?
    private var imageCache: UIImage?
    var image: UIImage? {
        set { setImage(value: newValue) }
        get { return getImage() }
    }


    override class func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["genre", "image", "imageCache"]
    }
}


// MARK: - Cache Logic

extension Product {

    private func setImage(value: UIImage?) {
        let image = value?.resized(withPercentage: 0.5)
        imageCache = image
        imageData = image?.pngData()
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
