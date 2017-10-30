//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation

class ProductListPresenter: ProductListPresenterProtocol, ProductListInteractorOutputProtocol {
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorInputProtocol?
    var wireFrame: ProductListWireframeProtocol?
    
    init() {}

    //MARK: Presenter Protocol

    func viewDidLoadEvent() {
        self.view?.showProgressIndicator()
        self.interactor?.fetchProducts()
    }

    func userDidSelectSortMethodAction(sortMethod: ProductListSortType) {
        self.interactor?.sortProducts(sortType: sortMethod)
    }

    //MARK: Interactor Output Protocol

    func presentProducts(products: [ProductListItem]) {
        self.view?.removeProgressIndicator()
        let viewItems = extractViewItemObjects(from: products)
        self.view?.show(productsViewItem: viewItems)
    }

    func presentError(errorTitle: String, errorMessage: String) {
        self.view?.removeProgressIndicator()
        self.wireFrame?.presentAlert(errorTitle: errorTitle, errorMessage: errorMessage)
    }

    //MARK: Private Methods
    private func extractViewItemObjects(from productListItens: [ProductListItem]) -> [ProductListViewItem] {
        var viewItems = [ProductListViewItem]()
        for productItem in productListItens {
            let viewItem = ProductListViewItem(name: productItem.title, price: productItem.price, rating: productItem.rating, imageURLString: productItem.image)
            viewItems.append(viewItem)
        }
        return viewItems
    }

}
