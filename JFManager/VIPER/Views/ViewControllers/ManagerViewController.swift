//
//  ManagerViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/15.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagerViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var presenter: ManagerPresenterProtocol!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTablaView()
        subscribe()
    }
}


// MARK: - Set Up

extension ManagerViewController {

    private func setUpTablaView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerCell(identifier: ToatalPriceTableViewCell.identifier)
        tableView.registerCell(identifier: ManagerTableViewCell.identifier)
        tableView.registerCell(identifier: SlackSendButtonCell.identifier)
    }

    private func subscribe() {
        presenter.totalPrice.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        presenter.managerUser.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDataSource

extension ManagerViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ToatalPriceTableViewCell.identifier, for: indexPath) as! ToatalPriceTableViewCell
            cell.set(price: presenter.totalPrice.value)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ManagerTableViewCell.identifier, for: indexPath) as! ManagerTableViewCell
            cell.set(genre: presenter.genre.value, user: presenter.managerUser.value)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SlackSendButtonCell.identifier, for: indexPath) as! SlackSendButtonCell
            cell.sendButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.presenter.sendReport()
            }).disposed(by: cell.disposeBag)
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ManagerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tapSelectManagerCell()
        }
    }

    private func tapSelectManagerCell() {
        let viewController = SelectManagerViewController.createFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .formSheet
        viewController.users = presenter.users.value
        viewController.genre = presenter.genre.value
        _ = viewController.obserber.subscribe(onNext: { [weak self] user in
            self?.presenter.changeManager(user: user)
            }, onCompleted: { () -> Void in
                viewController.dismiss(animated: true, completion: nil)
        })
        present(navigationController, animated: true, completion: nil)
    }
}
