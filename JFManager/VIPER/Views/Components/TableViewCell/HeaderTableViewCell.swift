//
//  HeaderTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class HeaderTableViewCell: UITableViewCell {


    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
}
