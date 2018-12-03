//
//  HistoryTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 5.0
    }
    
    func set(_ purchase: Purchase) {
        productImageView.image = purchase.product?.image
        priceLabel.text = "\(purchase.product?.price ?? 0)円"
        nameLabel.text = purchase.product.name

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        dateLabel.text = formatter.string(from: purchase.date)
    }
}
