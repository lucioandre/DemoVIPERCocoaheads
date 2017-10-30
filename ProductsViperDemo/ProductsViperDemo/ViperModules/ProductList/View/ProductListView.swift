//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import NVActivityIndicatorView

class ProductListView: UIViewController, ProductListViewProtocol, NVActivityIndicatorViewable {
    let cellIdentifier = String(describing: ProductListTableViewCell.self)
    var products: [ProductListViewItem]?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            let productCellNib = UINib(nibName: self.cellIdentifier, bundle: nil)
            self.tableView.register(productCellNib, forCellReuseIdentifier: cellIdentifier)
        }
    }

    //MARK: View Protocol
    var presenter: ProductListPresenterProtocol?

    func showProgressIndicator() {
        self.startAnimating(type: .ballTrianglePath)
    }

    func removeProgressIndicator() {
        self.stopAnimating()
    }

    func show(productsViewItem: [ProductListViewItem]) {
        self.products = productsViewItem
        self.tableView.reloadData()
    }

    //MARK: View Controller Life Cycle and User Interaction

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Premium Coffee"
        self.presenter?.viewDidLoadEvent()
    }

    @IBAction func sortFactorChanged(_ sender: UISegmentedControl) {
        if let sortType = ProductListSortType(rawValue: sender.selectedSegmentIndex) {
            self.presenter?.userDidSelectSortMethodAction(sortMethod: sortType)
        }
    }
}

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ProductListTableViewCell
        guard let viewItem:ProductListViewItem = self.products?[indexPath.row] else {
            return cell
        }
        cell.nameLabel.text = viewItem.name
        cell.priceLabel.text = viewItem.price
        cell.scoreLabel.text = viewItem.rating
        cell.productImageView.sd_setImage(with: viewItem.imageURL)
        return cell
    }
}
