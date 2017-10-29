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

    func userDidSelectSortMethod(sortMethod: ProductListSortType) {
        self.interactor?.sortProducts(sortType: sortMethod)
    }

    //MARK: Interactor Output Protocol

    func presentProducts(products: [ProductListItem]) {
        self.view?.removeProgressIndicator()
        self.view?.products = products
    }

    func presentError(errorTitle: String, errorMessage: String) {
        self.view?.removeProgressIndicator()
        self.wireFrame?.presentAlert(errorTitle: errorTitle, errorMessage: errorMessage)
    }
}
