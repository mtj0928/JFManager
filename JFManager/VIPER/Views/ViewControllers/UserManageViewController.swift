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
        tableView.delegate = self

        tableView.registerCell(identifier: UserShortCell.identifier)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: UserShortCell.identifier, for: indexPath) as! UserShortCell
        let position = presenter.positions.value[indexPath.section]
        if let user = presenter.users.value[position]?[indexPath.row] {
            cell.set(user)
        }
        return cell
    }
}


// MARK: - UITableViewDelegate

extension UserManageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = presenter.positions.value[indexPath.section]
        guard let user = presenter.users.value[position]?[indexPath.row] else { return }

        presenter.showDetail(user)
    }
}
