//
//  SettingViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var presenter: SettingPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
}


// MARK: - Set Up

extension SettingViewController {

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}


// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "ユーザー管理"
        return cell
    }
}


// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.tapUserManagerCell()
        }
    }
}
