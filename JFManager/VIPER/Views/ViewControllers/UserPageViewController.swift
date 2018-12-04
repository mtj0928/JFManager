//
//  UserPageViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserPageViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var preseter: UserPagePresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
}


// MARK: - Set Up

extension UserPageViewController {

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension

        tableView.registerCell(identifier: UserProfileTableViewCell.identifier)
        tableView.registerCell(identifier: ProductsTableViewCell.identifier)
        tableView.registerCell(identifier: HeaderTableViewCell.identifier)
        tableView.registerCell(identifier: HistoryTableViewCell.identifier)

        preseter.history.asDriver().drive(onNext: { [weak self] _ in
            self?.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
        }).disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDataSource

extension UserPageViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            let history = preseter.history.value
            return history.isEmpty ? 0 : history.count + 1
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as! UserProfileTableViewCell
            cell.set(preseter.user.value)
            return cell
        } else if indexPath.section == 1 || indexPath.section == 2 {
            let genre: Genre = indexPath.section == 1 ? .drink : .food
            let products = preseter.products.value[genre] ?? []
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as! ProductsTableViewCell
            cell.set(products, genre: genre) { [weak self] product in
                self?.preseter.tapProduct(product)
            }
            return cell
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
                cell.title = "購入履歴"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
                let purchase = preseter.history.value[indexPath.row - 1]
                cell.set(purchase)
                return cell
            }
        }
        return UITableViewCell()
    }
}


// MARK: - UITableViewDelegate
 
extension UserPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 3 && indexPath.row != 0 else {
            return nil
        }
        let action = UIContextualAction(style: .destructive, title: "取り消し") { [weak self] (action, view, completionHandler) in
            guard let purchase = self?.preseter.history.value[indexPath.row - 1] else { return }
            self?.preseter.toggle(purchase)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}
