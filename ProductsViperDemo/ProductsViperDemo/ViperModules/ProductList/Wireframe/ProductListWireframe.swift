//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation
import UIKit

class ProductListWireframe: ProductListWireframeProtocol {
    let view: View
    init(view: View) {
        self.view = view
    }

    //MARK: Instance Methods

    func presentAlert(errorTitle: String, errorMessage: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.view.present(alertController, animated: true, completion: nil)
    }

    //MARK: Static Method

    class func configureViewController() -> UIViewController {
        // Generating module components
        let view: ProductListViewProtocol = ProductListView()
        let presenter: ProductListPresenterProtocol & ProductListInteractorOutputProtocol = ProductListPresenter()
        let interactor: ProductListInteractorInputProtocol = ProductListInteractor()
        let APIDataManager: ProductListAPIDataManagerInputProtocol = ProductListAPIDataManager()
        let localDataManager: ProductListLocalDataManagerInputProtocol = ProductListLocalDataManager()
        let wireFrame: ProductListWireframeProtocol = ProductListWireframe(view: view)

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager

        return view as! UIViewController
    }
}
