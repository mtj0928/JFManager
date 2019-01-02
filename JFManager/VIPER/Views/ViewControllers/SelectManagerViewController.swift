//
//  SelectManagerViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2019/01/02.
//  Copyright © 2019 Kusumoto Lab. All rights reserved.
//

import UIKit
import RxSwift

class SelectManagerViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var genre: Genre!
    var users: [User]!
    var obserber: Observable<User> {
        return subject
    }
    private let subject: PublishSubject<User> = PublishSubject()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }
}

// MARK: - Set Up

extension SelectManagerViewController {

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerCell(identifier: UserShortCell.identifier)
    }

    private func setupNavigationBar() {
        navigationItem.title = genre.japanese + "大臣を選択"
    }
}


// MARK: - UITableViewDataSource

extension SelectManagerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserShortCell.identifier, for: indexPath) as! UserShortCell
        cell.set(users[indexPath.row])
        return cell
    }
}


// MARK: UITableViewDelegate

extension SelectManagerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        subject.onNext(user)
        subject.onCompleted()
    }
}
