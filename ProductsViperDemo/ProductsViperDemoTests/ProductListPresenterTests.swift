//
//  ProductListPresenterTests.swift
//  ProductsViperDemoTests
//
//  Created by Avenue Brazil on 29/10/17.
//  Copyright © 2017 LucioFonseca. All rights reserved.
//

import XCTest
@testable import ProductsViperDemo

class ProductListPresenterTests: XCTestCase {

    var productListPresenter: ProductListPresenter?
    
    override func setUp() {
        super.setUp()
        self.productListPresenter = ProductListPresenter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testViewDidLoadEventShouldCallInteractorFetchProducts() {
        //Prepare
        let mockProductListInteractor = MockProductListInteractor()
        self.productListPresenter?.interactor = mockProductListInteractor
        //Exercise
        self.productListPresenter?.viewDidLoadEvent()
        //Verify
        XCTAssert(mockProductListInteractor.fetchProductsCallCount == 1, "ViewDidLoadEvent should call FetchProducts once")
    }

    func testViewDidLoadEventShouldShowProgressIndicator() {
        //Prepare
        let mockProductListView = MockProductListView()
        self.productListPresenter?.view = mockProductListView
        //Exercise
        self.productListPresenter?.viewDidLoadEvent()
        //Verify
        XCTAssert(mockProductListView.showProgressIndicatorCallCount == 1, "ViewDidLoadEvent should show Progress Indicator at View")
    }

    func testUserDidSelectSortMethodNameActionShouldCallInteractorSortProducts() {
        //Prepare
        let mockProductListInteractor = MockProductListInteractor()
        self.productListPresenter?.interactor = mockProductListInteractor
        //Exercise
        self.productListPresenter?.userDidSelectSortMethodAction(sortMethod: .Name)
        //Verify
        XCTAssert(mockProductListInteractor.sortProductsCallCount == 1, "userDidSelectSort for Name option should call Interactor's sortProduct once")
    }

    func testUserDidSelectSortMethodPriceActionShouldCallInteractorSortProducts() {
        //Prepare
        let mockProductListInteractor = MockProductListInteractor()
        self.productListPresenter?.interactor = mockProductListInteractor
        //Exercise
        self.productListPresenter?.userDidSelectSortMethodAction(sortMethod: .Price)
        //Verify
        XCTAssert(mockProductListInteractor.sortProductsCallCount == 1, "userDidSelectSort for Price option should call Interactor's sortProduct once")
    }

    func testUserDidSelectSortMethodRatingActionShouldCallInteractorSortProducts() {
        //Prepare
        let mockProductListInteractor = MockProductListInteractor()
        self.productListPresenter?.interactor = mockProductListInteractor
        //Exercise
        self.productListPresenter?.userDidSelectSortMethodAction(sortMethod: .Rating)
        //Verify
        XCTAssert(mockProductListInteractor.sortProductsCallCount == 1, "userDidSelectSort for Rating option should call Interactor's sortProduct once")
    }

    func testPresentProductsShouldRemoveProgressIndicator() {
        //Prepare
        let mockProductListView = MockProductListView()
        self.productListPresenter?.view = mockProductListView
        let product1 = ProductListItem(title: "C", description: "C", price: 5.0, rating: 7.0, image: "")
        //Exercise
        self.productListPresenter?.presentProducts(products: [product1])
        //Verify
        XCTAssert(mockProductListView.removeProgressIndicatorCallCount == 1, "PresentProducts should remove Progress Indicator at View")
    }

    func testPresentProductsShouldSetViewProducts() {
        //Prepare
        let mockProductListView = MockProductListView()
        self.productListPresenter?.view = mockProductListView
        let product1 = ProductListItem(title: "C", description: "C", price: 5.0, rating: 7.0, image: "")
        //Exercise
        self.productListPresenter?.presentProducts(products: [product1])
        //Verify
        XCTAssert(mockProductListView.removeProgressIndicatorCallCount == 1, "PresentProducts should remove Progress Indicator at View")
    }

    func testPresentErrorShouldRemoveProgressIndicator() {
        //Prepare
        let mockProductListView = MockProductListView()
        self.productListPresenter?.view = mockProductListView
        //Exercise
        self.productListPresenter?.presentError(errorTitle: "", errorMessage: "")
        //Verify
        XCTAssert(mockProductListView.removeProgressIndicatorCallCount == 1, "PresentError should remove Progress Indicator at View")
    }

    func testPresentErrorShouldCallWireframeToPresentAlert() {
        //Prepare
        let mockProductListWireframe = MockProductListWireframe()
        self.productListPresenter?.wireFrame = mockProductListWireframe
        //Exercise
        self.productListPresenter?.presentError(errorTitle: "", errorMessage: "")
        //Verify
        XCTAssert(mockProductListWireframe.presentAlertCallCount == 1, "PresentError should ask Wireframe to present Alert")
    }

    //MARK: Mock Classes
    class MockProductListView: ProductListViewProtocol {
        var presenter: ProductListPresenterProtocol?

        var didSetProductsCallCount = 0
        var products: [ProductListItem]? {
            didSet {
                didSetProductsCallCount += 1
            }
        }

        var showProgressIndicatorCallCount = 0
        func showProgressIndicator() {
            showProgressIndicatorCallCount += 1
        }

        var removeProgressIndicatorCallCount = 0
        func removeProgressIndicator() {
            removeProgressIndicatorCallCount += 1
        }

        var navigationController: UINavigationController?
        func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) { }
    }

    class MockProductListInteractor: ProductListInteractorInputProtocol {
        var presenter: ProductListInteractorOutputProtocol?
        var APIDataManager: ProductListAPIDataManagerInputProtocol?
        var localDatamanager: ProductListLocalDataManagerInputProtocol?

        var fetchProductsCallCount = 0
        func fetchProducts() {
            fetchProductsCallCount += 1
        }

        var sortProductsCallCount = 0
        func sortProducts(sortType: ProductListSortType) {
            sortProductsCallCount += 1
        }
    }

    class MockProductListWireframe: ProductListWireframeProtocol {
        var presentAlertCallCount = 0
        func presentAlert(errorTitle: String, errorMessage: String) {
            presentAlertCallCount += 1
        }
    }
}
