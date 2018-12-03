//
//  UserPageViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit

class UserPageViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var preseter: UserPagePresenterProtocol!

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
    }
}


// MARK: - UITableViewDataSource

extension UserPageViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as! UserProfileTableViewCell
            let user = preseter.user.value
            cell.set(user)
            return cell
        } else if indexPath.section == 1 || indexPath.section == 2 {
            let genre: Genre = indexPath.section == 1 ? .drink : .food
            let products = preseter.products.value[genre] ?? []
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as! ProductsTableViewCell
            cell.set(products, genre: genre)
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: - UITableViewDelgate
 
extension UserPageViewController: UITableViewDelegate {

}
