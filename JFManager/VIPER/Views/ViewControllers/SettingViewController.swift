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
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "ジュース会"
        } else if section == 2 {
            return "食品会"
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 || section == 2 {
            return 2
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "ユーザー管理"
        } else if indexPath.section == 1 || indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text =  "商品管理"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "売り上げ"
            }
        }
        return cell
    }
}


// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.tapUserManagerCell()
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                presenter.tapProductListCell(genre: .drink)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                presenter.tapProductListCell(genre: .food)
            }
        }
    }
}
