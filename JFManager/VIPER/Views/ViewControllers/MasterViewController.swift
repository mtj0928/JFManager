//
//  MasterViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MasterViewController: UIViewController {


    @IBOutlet private weak var tableView: UITableView!

    var preseter: MasterPresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
}


// MARK: - Set Up

extension MasterViewController {

    private func setUpTableView() {
        tableView.registerCell(identifier: UserShortCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        preseter.update.asDriver(onErrorDriveWith: Driver.empty()).drive(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDataSource

extension MasterViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return preseter.positions.value.count + 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !isSettingSection(section) {
            return preseter.positions.value[section].name
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSettingSection(section) {
            return 1
        }
        let position = preseter.positions.value[section]
        return preseter.users.value[position]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSettingSection(indexPath.section) {
            return settingCell(indexPath)
        }
        return userCell(indexPath)
    }

    private func isSettingSection(_ section: Int) -> Bool {
        return section == preseter.positions.value.count
    }

    private func userCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserShortCell.identifier, for: indexPath) as! UserShortCell
        let position = preseter.positions.value[indexPath.section]
        let user = preseter.users.value[position]![indexPath.row]
        cell.set(user)
        return cell
    }

    private func settingCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "設定"
        return cell
    }
}


// MARK: - UITableViewDelegate

extension MasterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != preseter.positions.value.count {
            let position = preseter.positions.value[indexPath.section]
            if let user = preseter.users.value[position]?[indexPath.row] {
                preseter.show(user: user)
            }
        } else {
            preseter.showSetting()
        }
    }
}
