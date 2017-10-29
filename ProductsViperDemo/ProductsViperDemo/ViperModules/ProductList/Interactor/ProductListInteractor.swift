//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation

enum ProductListSortType: Int {
    case Rating = 0
    case Price
    case Name
}

enum APIErrors: Error {
    case NoConnection
    case JSONParseFailed
    case ConnectionFailed
}

class ProductListInteractor: ProductListInteractorInputProtocol {
    weak var presenter: ProductListInteractorOutputProtocol?
    var APIDataManager: ProductListAPIDataManagerInputProtocol?
    var localDatamanager: ProductListLocalDataManagerInputProtocol?

    var productList: [ProductListItem]?
    
    init() {}

    func fetchProducts() {
        self.APIDataManager?.getProducts(completion: { (productList, error) in
            if error == nil {
                self.productList = productList
                self.sortProducts(sortType: .Rating)
            }
            else {
                self.presenter?.presentError(errorTitle: "It was not possible load Products", errorMessage: "Please try again Later.")
            }
        })
    }

    func sortProducts(sortType: ProductListSortType) {
        if let _productList = self.productList {
            var sortedProducts: [ProductListItem]
            switch sortType {
            case .Name:
                sortedProducts = _productList.sorted(by: { (productA: ProductListItem, productB: ProductListItem) -> Bool in
                    return productA.title < productB.title
                })
            case .Price:
                sortedProducts = _productList.sorted(by: { (productA: ProductListItem, productB: ProductListItem) -> Bool in
                    return productA.price < productB.price
                })
            case .Rating:
                sortedProducts = _productList.sorted(by: { (productA: ProductListItem, productB: ProductListItem) -> Bool in
                    return productA.rating > productB.rating
                })
            }

            self.presenter?.presentProducts(products: sortedProducts)
        }
    }
}
