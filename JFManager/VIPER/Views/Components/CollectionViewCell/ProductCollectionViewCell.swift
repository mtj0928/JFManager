//
//  ProductCollectionViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 10.0
    }

    func set(_ product: Product) {
        let image = product.image
        productImageView.image = image
        productNameLabel.text = product.name
        priceLabel.text = "\(product.price) 円"
    }
}
