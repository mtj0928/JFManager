//
//  ProductsTableViewCell.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/12/03.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet private weak var genreNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    private var products: [Product] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpCollectionView()
    }

    func set(_ products: [Product], genre: Genre) {
        genreNameLabel.text = genre.rawValue
        self.products = products
        self.collectionView.reloadData()
    }
}


// MARK: - Set Up

extension ProductsTableViewCell {

    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.alwaysBounceHorizontal = true

        collectionView.registerCell(identifier: ProductCollectionViewCell.identifier)
    }
}


// MARK: - UICollectionViewCellDataSource

extension ProductsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.set(products[indexPath.item])
        return cell
    }
}


// MARK: - UICoctionViewDelegate

extension ProductsTableViewCell: UICollectionViewDelegate {

}


// MARK: - UICollectionViewDelegateFlowLayout 

extension ProductsTableViewCell: UICollectionViewDelegateFlowLayout {

    private var margin: CGFloat {
        return 12.0
    }
    private var numberOfCoumn: CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let multiple: CGFloat = 2 / 3
        return CGSize(width: height * multiple, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

}
