//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation
import UIKit

protocol ProductListViewProtocol: View {
    var presenter: ProductListPresenterProtocol? { get set }
    var products: [ProductListItem]? { get set }
    func showProgressIndicator()
    func removeProgressIndicator()
}

protocol ProductListWireframeProtocol: class {
    func presentAlert(errorTitle: String, errorMessage: String)
}

protocol ProductListPresenterProtocol: class {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorInputProtocol? { get set }
    var wireFrame: ProductListWireframeProtocol? { get set }

    func viewDidLoadEvent()
    func userDidSelectSortMethod(sortMethod: ProductListSortType)
}

protocol ProductListInteractorOutputProtocol: class {
    func presentProducts(products:[ProductListItem])
    func presentError(errorTitle: String, errorMessage: String)
}

protocol ProductListInteractorInputProtocol: class {
    var presenter: ProductListInteractorOutputProtocol? { get set }
    var APIDataManager: ProductListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ProductListLocalDataManagerInputProtocol? { get set }

    func fetchProducts()
    func sortProducts(sortType: ProductListSortType)
}

protocol ProductListAPIDataManagerInputProtocol: class {
    func getProducts(completion: @escaping (_ products:[ProductListItem]?, _ error:Error?) -> Swift.Void)
}

protocol ProductListLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
