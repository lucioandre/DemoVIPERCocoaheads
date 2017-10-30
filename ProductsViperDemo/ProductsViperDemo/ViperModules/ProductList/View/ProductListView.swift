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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            let productCellNib = UINib(nibName: self.cellIdentifier, bundle: nil)
            self.tableView.register(productCellNib, forCellReuseIdentifier: cellIdentifier)
        }
    }

    //MARK: View Protocol
    var presenter: ProductListPresenterProtocol?

    var products: [ProductListItem]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    func showProgressIndicator() {
        self.startAnimating(type: .ballTrianglePath)
    }

    func removeProgressIndicator() {
        self.stopAnimating()
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
        guard let product:ProductListItem = self.products?[indexPath.row] else {
            return cell
        }
        cell.nameLabel.text = product.title.uppercased()
        cell.priceLabel.text = String(format: "$%.2f", arguments: [product.price])
        cell.scoreLabel.text = "\(product.rating)"
        let imageURL = URL(string: product.image)
        cell.productImageView.sd_setImage(with: imageURL)
        return cell
    }
}
