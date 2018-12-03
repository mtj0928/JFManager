//
//  PurchaseConfirmViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PurchaseConfirmViewController: UITableViewController {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var confirmLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var purchaseButton: UIButton!

    var presenter: PurchaseConfirmPresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpImageView()
        setUpLabel()
        setUpButton()
    }

    @IBAction func tapCancel() {
        presenter.cancel()
    }

    @IBAction func tapPurchase() {
        presenter.purchase()
    }
}


// MARK: - Set Up

extension PurchaseConfirmViewController {

    private func setUpImageView() {
        userImageView.image = presenter.user.value.image
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2

        productImageView.image = presenter.product.value.image
        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 10.0
    }

    private func setUpLabel() {
        confirmLabel.text = "\(presenter.product.value.name)を購入しますか？"
    }

    private func setUpButton() {
        [cancelButton, purchaseButton].forEach { button in
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = 5.0
        }
    }
}


// MARK: - UITableViewDelegate

extension PurchaseConfirmViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}
