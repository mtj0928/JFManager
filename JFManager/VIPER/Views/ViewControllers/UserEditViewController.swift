//
//  AddUserViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserEditViewController: UITableViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var positionTextField: UITextField!

    var presenter: UserEditPresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpImageView()
        setUpNavigationBar()
        setUpTextFields()
        setUpPicker()
    }
}


// MARK: - Set Up

extension UserEditViewController {

    private func setUpImageView() {
        presenter.image
            .asDriver()
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setUpTextFields() {
        nameTextField.text = presenter.name.value

        nameTextField.rx
            .text
            .asDriver()
            .map({ $0! })
            .drive(presenter.name)
            .disposed(by: disposeBag)

        presenter.selectedPositionName
            .asDriver()
            .drive(positionTextField.rx.text)
            .disposed(by: disposeBag)
    }

    private func setUpNavigationBar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cencel))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.deleteUser))
        navigationItem.leftBarButtonItems = [cancelButton, deleteButton]

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func cencel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc private func save() {
        presenter.saveUser()
    }

    @objc private func deleteUser() {
        presenter.deleteUser()
    }

    private func setUpPicker() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        positionTextField.inputView = pickerView
    }
}


// MARK: - Methods

extension UserEditViewController {

    func presentShowAlertView() {
        let alertController = UIAlertController(title: "役職を追加", message: "役職を追加してください(教員、B4など)", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder  = "役職"
        }

        let cancelAction = UIAlertAction(title: "キャンセル", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let textField = alertController.textFields?.first else { return }

            self?.presenter.selectedPositionName.accept(textField.text)
            self?.positionTextField.resignFirstResponder()
        })
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDelegate

extension UserEditViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }
}


// - MARK: UIPickerViewDataSource

extension UserEditViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.positions.value.count + 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if presenter.positions.value.count != row {
            return presenter.positions.value[row].name
        }
        return "追加する"
    }
}


// - MARK: UIPickerViewDelegate

extension UserEditViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if presenter.positions.value.count == row {
            presentShowAlertView()
        } else {
            presenter.selectPosition(at: row)
        }
    }
}


//MARK: - UIImagePickerControllerDelegate

extension UserEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        presenter.image.accept(image.fixedOrientation())
        picker.dismiss(animated: true, completion: nil)
    }
}
