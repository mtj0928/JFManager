//
//  ToatalPriceTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/16.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

class ToatalPriceTableViewCell: UITableViewCell {

    @IBOutlet private weak var priceLabel: UILabel!

    func set(price: Int) {
        priceLabel.text = "\(price)"
    }
}
