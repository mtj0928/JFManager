//
//  SettingViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/01.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case user, slack, drink, food
    }

    @IBOutlet private weak var tableView: UITableView!

    var presenter: SettingPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


// MARK: - Set Up

extension SettingViewController {

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setUpNavigationBar() {
        navigationItem.title = "設定"
    }
}


// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let category = Section(rawValue: section) else { return nil }

        switch category {
        case .drink:
            return "ジュース会"
        case .food:
            return "食品会"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = Section(rawValue: section) else { return 0 }
        switch category {
        case .drink, .food:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let section = Section(rawValue: indexPath.section) else {
            return cell
        }
        switch section {
        case .drink, .food:
            cell.textLabel?.text = indexPath.row == 0 ? "商品管理" : "売り上げ"
        case .slack:
            cell.textLabel?.text = "Slackの設定"
        case .user:
            cell.textLabel?.text = "ユーザー管理"
        }
        return cell
    }
}


// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .user:
            presenter.tapUserManagerCell()
        case .slack:
            presenter.tapSlackSetingCell()
        case .drink:
            if indexPath.row == 0 {
                presenter.tapProductListCell(genre: .drink)
            } else if indexPath.row == 1 {
                presenter.tapManager(genre: .drink)
            }
        case .food:
            if indexPath.row == 0 {
                presenter.tapProductListCell(genre: .food)
            } else if indexPath.row == 1 {
                presenter.tapManager(genre: .food)
            }
        }
    }
}
