//
//  UserShortCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class UserShortCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!

    private weak var user: User?
    private var notificationToken: NotificationToken?

    override func awakeFromNib() {
        super.awakeFromNib()

        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
    }

    func set(_ user: User) {
        self.user = user
        nameLabel.text = user.name
        iconImageView.image = user.image
    }
}
