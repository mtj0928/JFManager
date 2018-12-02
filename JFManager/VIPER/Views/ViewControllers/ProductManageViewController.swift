//
//  ProductManageViewController.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/02.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductManageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: ProductManagePresenterProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        setUpNavigationBar()
    }
}


// MARK: - Set Up

extension ProductManageViewController {

    private func setUpNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func add() {
        presenter.addProduct()
    }

    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.registerCell(identifier: ProductCollectionViewCell.identifier)

        collectionView.alwaysBounceVertical = true

        presenter.update
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}


//MARK: - UICollectiomViewDataSource

extension ProductManageViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presenter.products.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let product = presenter.products.value[indexPath.item]
        cell.set(product)
        return cell
    }
}


// MARK: - UIOollectonViewDelegate

extension ProductManageViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(about: presenter.products.value[indexPath.item])
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension ProductManageViewController: UICollectionViewDelegateFlowLayout {

    private var margin: CGFloat {
        return 12.0
    }
    private var numberOfCoumn: CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width
        let cellWidth = (w - margin) / numberOfCoumn - margin
        let multiple: CGFloat = indexPath.item == presenter.products.value.count ? 1.0 : 1.5
        return CGSize(width: cellWidth, height: cellWidth * multiple)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}
