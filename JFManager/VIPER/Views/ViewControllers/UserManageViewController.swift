//
//  UserMnageViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserManageViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var presenter: UserManagePresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setNavigationBar()
    }
}


// - MARK: Set Up

extension UserManageViewController {

    private func setUpTableView() {
        tableView.dataSource = self

        presenter.update.asDriver(onErrorDriveWith: Driver.empty()).drive(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

    private func setNavigationBar() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.tapAddButton))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func tapAddButton() {
        presenter.tapAddUser()
    }
}


// - MARK: - UITableViewDataSource

extension UserManageViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.positions.value.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.positions.value[section].name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let position = presenter.positions.value[section]
        return presenter.users.value[position]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let position = presenter.positions.value[indexPath.section]
        let user = presenter.users.value[position]?[indexPath.row]
        cell.textLabel?.text = user?.name
        return cell
    }
}
