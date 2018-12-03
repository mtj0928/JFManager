//
//  UserProfileTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var pricaeLabel: UILabel!

    private var notification: NotificationToken?

    private weak var user: User?

    override func awakeFromNib() {
        super.awakeFromNib()

        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        notification?.invalidate()
    }

    func set(_ user: User) {
        notification?.invalidate()
        self.user = user
        update()
        notification = user.observe({ [weak self] _ in
            self?.update()
        })
    }

    private func update() {
        guard let user = user else { return }

        nameLabel.text = user.name
        iconImageView.image = user.image
        pricaeLabel.text = "\(user.nowPrice)円"
    }
}
