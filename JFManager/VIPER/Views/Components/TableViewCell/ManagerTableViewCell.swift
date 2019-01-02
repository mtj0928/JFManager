//
//  ManagerTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/16.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class ManagerTableViewCell: UITableViewCell {
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var managerNameLabel: UILabel!
    @IBOutlet private weak var managerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(genre: Genre, user: User?) {
        roleLabel.text = genre.japanese + "大臣"
        if let user = user {
            managerImageView.image = user.image
            managerNameLabel.text = user.name
        } else {
            managerImageView.image = nil
            managerNameLabel.text = "未設定"
        }
    }
}
