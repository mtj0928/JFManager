//
//  SlackEditViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/05.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SlackEditViewController: UITableViewController {
    
    @IBOutlet private weak var tokenTextField: UITextField!
    @IBOutlet private weak var reportTextField: UITextField!
    @IBOutlet private weak var drinkTextField: UITextField!
    @IBOutlet private weak var foodTextField: UITextField!

    var presenter: SlackEditPresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTextField()
        setUpNavigationBar()
    }
}


// MARK: - Set Up

extension SlackEditViewController {

    private func setUpTextField() {
        tokenTextField.text = presenter.token.value
        reportTextField.text = presenter.reportChannel.value
        drinkTextField.text = presenter.drinkChannel.value
        foodTextField.text = presenter.foodChannel.value

        tokenTextField.rx
            .text
            .asDriver()
            .map({ $0! })
            .drive(presenter.token)
            .disposed(by: disposeBag)

        reportTextField.rx
            .text
            .asDriver()
            .map({ $0! })
            .drive(presenter.reportChannel)
            .disposed(by: disposeBag)

        drinkTextField.rx
            .text
            .asDriver()
            .map({ $0! })
            .drive(presenter.drinkChannel)
            .disposed(by: disposeBag)

        foodTextField.rx
            .text
            .asDriver()
            .map({ $0! })
            .drive(presenter.foodChannel)
            .disposed(by: disposeBag)
    }

    private func setUpNavigationBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func save() {
        presenter.save()
    }
}
