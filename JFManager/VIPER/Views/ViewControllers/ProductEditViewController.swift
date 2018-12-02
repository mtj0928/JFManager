//
//  ProductEditViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductEditViewController: UITableViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!

    var presenter: ProductEditPresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpTextFields()
        setUpImageView()
    }
}


// MARK: - Set Up

extension ProductEditViewController {

    private func setUpNavigationBar() {
        let cencelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        navigationItem.leftBarButtonItem = cencelButton

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.deleteAction))
        if (presenter.shouldShowDeleteButton.value) {
            navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        } else {
            navigationItem.rightBarButtonItem = saveButton
        }
    }

    @objc private func cancel() {
        presenter.cancel()
    }

    @objc private func deleteAction() {
        let alertController = UIAlertController(title: "\(presenter.productName.value)を削除しますか？", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let deleteAction = UIAlertAction(title: "削除", style: .destructive) { [weak self] _ in
            self?.presenter.delete()
        }
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func save() {
        presenter.save()
    }

    private func setUpTextFields() {
        nameTextField.text = presenter.productName.value
        priceTextField.text = "\(presenter.productPrice.value)"

        nameTextField.rx
            .text
            .asDriver()
            .map({ $0 ?? "" })
            .drive(presenter.productName)
            .disposed(by: disposeBag)

        priceTextField.rx
            .text
            .asDriver()
            .map({ Int($0 ?? "%") ?? 0 })
            .drive(presenter.productPrice)
            .disposed(by: disposeBag)
    }

    private func setUpImageView() {
        presenter.productImage
            .asDriver()
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDelgate

extension ProductEditViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }
}


//MARK: - UIImagePickerControllerDelegate

extension ProductEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        presenter.productImage.accept(image)
    }
}
