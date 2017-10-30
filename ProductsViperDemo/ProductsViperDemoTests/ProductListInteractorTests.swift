//
//  ProductListInteractorTests.swift
//  ProductsViperDemoTests
//
//  Created by Avenue Brazil on 29/10/17.
//  Copyright © 2017 LucioFonseca. All rights reserved.
//

import XCTest
@testable import ProductsViperDemo

class ProductListInteractorTests: XCTestCase {

    var productListInteractor: ProductListInteractor?
    
    override func setUp() {
        super.setUp()
        self.productListInteractor = ProductListInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFetchProductsShouldCallAPIDataManager() {
        class MockProductListAPIDataManager: ProductListAPIDataManagerInputProtocol {
            var getProductsCallCount = 0
            func getProducts(completion: @escaping ([ProductListItem]?, Error?) -> Void) {
                getProductsCallCount += 1
            }
        }

        //Prepare
        let mockAPIDataManager = MockProductListAPIDataManager()
        self.productListInteractor?.APIDataManager = mockAPIDataManager
        //Exercise
        self.productListInteractor?.fetchProducts()
        //Verify
        XCTAssert(mockAPIDataManager.getProductsCallCount == 1, "fetchProducts should call APIDataManager once")
    }

    func testFetchProductsShouldCallSortProducts() {

        class MockProductListAPIDataManager: ProductListAPIDataManagerInputProtocol {
            var getProductsCallCount = 0
            func getProducts(completion: @escaping ([ProductListItem]?, Error?) -> Void) {
                let product1 = ProductListItem(title: "A", description: "A", price: 5.0, rating: 7.0, image: "")
                let product2 = ProductListItem(title: "B", description: "B", price: 5.0, rating: 10.0, image: "")
                let product3 = ProductListItem(title: "C", description: "C", price: 5.0, rating: 3.0, image: "")

                completion([product1, product2, product3], nil)
            }
        }

        class MockProductListPresenter: ProductListInteractorOutputProtocol {
            var presentProductsCallCount = 0
            func presentProducts(products: [ProductListItem]) {
                presentProductsCallCount += 1
                XCTAssert(products.count == 3, "Number of ProductListItems should be 3")
                for index in 1 ... products.count-1 {
                    XCTAssert(products[index-1].rating > products[index].rating, "Rating should decrease")
                }
            }

            var presentErrorCallCount = 0
            func presentError(errorTitle: String, errorMessage: String) {
                presentErrorCallCount += 1
            }
        }

        //Prepare
        let mockProductListAPIDataManager = MockProductListAPIDataManager()
        self.productListInteractor?.APIDataManager = mockProductListAPIDataManager
        let mockProductListPresenter = MockProductListPresenter()
        self.productListInteractor?.presenter = mockProductListPresenter
        //Exercise
        self.productListInteractor?.fetchProducts()
        //Verify
        XCTAssert(mockProductListPresenter.presentProductsCallCount == 1, "Interactor should output products to Presenter")
        XCTAssert(mockProductListPresenter.presentErrorCallCount == 0, "Interactor should not output error to Presenter")
    }

    func testFetchProductsWithErrorShouldOutputErrorMessage() {

        class MockProductListAPIDataManager: ProductListAPIDataManagerInputProtocol {
            func getProducts(completion: @escaping ([ProductListItem]?, Error?) -> Void) {
                completion(nil, APIErrors.ConnectionFailed)
            }
        }

        class MockProductListPresenter: ProductListInteractorOutputProtocol {
            var presentProductsCallCount = 0
            func presentProducts(products: [ProductListItem]) {
                presentProductsCallCount += 1
            }

            var presentErrorCallCount = 0
            func presentError(errorTitle: String, errorMessage: String) {
                presentErrorCallCount += 1
            }
        }

        //Prepare
        let mockProductListAPIDataManager = MockProductListAPIDataManager()
        self.productListInteractor?.APIDataManager = mockProductListAPIDataManager
        let mockProductListPresenter = MockProductListPresenter()
        self.productListInteractor?.presenter = mockProductListPresenter
        //Exercise
        self.productListInteractor?.fetchProducts()
        //Verify
        XCTAssert(mockProductListPresenter.presentErrorCallCount == 1, "Interactor should output error to Presenter")
        XCTAssert(mockProductListPresenter.presentProductsCallCount == 0, "Interactor should not output products to Presenter")
    }

    func testSortProductsTypeRatingShouldOutputResultsSortedByRating() {
        class MockProductListPresenter: ProductListInteractorOutputProtocol {
            var presentProductsCallCount = 0
            func presentProducts(products: [ProductListItem]) {
                presentProductsCallCount += 1
                XCTAssert(products.count == 3, "Number of ProductListItems should be 3")
                for index in 1 ... products.count-1 {
                    XCTAssert(products[index-1].rating > products[index].rating, "Rating should decrease")
                }
            }

            var presentErrorCallCount = 0
            func presentError(errorTitle: String, errorMessage: String) {
                presentErrorCallCount += 1
            }
        }

        //Prepare
        let mockProductListPresenter = MockProductListPresenter()
        self.productListInteractor?.presenter = mockProductListPresenter
        let product1 = ProductListItem(title: "A", description: "A", price: 5.0, rating: 7.0, image: "")
        let product2 = ProductListItem(title: "B", description: "B", price: 5.0, rating: 10.0, image: "")
        let product3 = ProductListItem(title: "C", description: "C", price: 5.0, rating: 3.0, image: "")
        self.productListInteractor?.productList = [product1, product2, product3]
        //Exercise
        self.productListInteractor?.sortProducts(sortType: .Rating)
        //Verify
        XCTAssert(mockProductListPresenter.presentProductsCallCount == 1, "Interactor should output products to Presenter")
        XCTAssert(mockProductListPresenter.presentErrorCallCount == 0, "Interactor should not output error to Presenter")
    }

    func testSortProductsTypeNameShouldOutputResultsSortedByName() {
        class MockProductListPresenter: ProductListInteractorOutputProtocol {
            var presentProductsCallCount = 0
            func presentProducts(products: [ProductListItem]) {
                presentProductsCallCount += 1
                XCTAssert(products.count == 3, "Number of ProductListItems should be 3")
                for index in 1 ... products.count-1 {
                    XCTAssert(products[index-1].title < products[index].title, "Title should increase")
                }
            }

            var presentErrorCallCount = 0
            func presentError(errorTitle: String, errorMessage: String) {
                presentErrorCallCount += 1
            }
        }

        //Prepare
        let mockProductListPresenter = MockProductListPresenter()
        self.productListInteractor?.presenter = mockProductListPresenter
        let product1 = ProductListItem(title: "C", description: "C", price: 5.0, rating: 7.0, image: "")
        let product2 = ProductListItem(title: "B", description: "B", price: 5.0, rating: 10.0, image: "")
        let product3 = ProductListItem(title: "A", description: "A", price: 5.0, rating: 3.0, image: "")
        self.productListInteractor?.productList = [product1, product2, product3]
        //Exercise
        self.productListInteractor?.sortProducts(sortType: .Name)
        //Verify
        XCTAssert(mockProductListPresenter.presentProductsCallCount == 1, "Interactor should output products to Presenter")
        XCTAssert(mockProductListPresenter.presentErrorCallCount == 0, "Interactor should not output error to Presenter")
    }

    func testSortProductsTypePriceShouldOutputResultsSortedByPrice() {
        class MockProductListPresenter: ProductListInteractorOutputProtocol {
            var presentProductsCallCount = 0
            func presentProducts(products: [ProductListItem]) {
                presentProductsCallCount += 1
                XCTAssert(products.count == 3, "Number of ProductListItems should be 3")
                for index in 1 ... products.count-1 {
                    XCTAssert(products[index-1].price < products[index].price, "Price should increase")
                }
            }

            var presentErrorCallCount = 0
            func presentError(errorTitle: String, errorMessage: String) {
                presentErrorCallCount += 1
            }
        }

        //Prepare
        let mockProductListPresenter = MockProductListPresenter()
        self.productListInteractor?.presenter = mockProductListPresenter
        let product1 = ProductListItem(title: "C", description: "C", price: 203.0, rating: 7.0, image: "")
        let product2 = ProductListItem(title: "B", description: "B", price: 202.0, rating: 10.0, image: "")
        let product3 = ProductListItem(title: "A", description: "A", price: 205.0, rating: 3.0, image: "")
        self.productListInteractor?.productList = [product1, product2, product3]
        //Exercise
        self.productListInteractor?.sortProducts(sortType: .Price)
        //Verify
        XCTAssert(mockProductListPresenter.presentProductsCallCount == 1, "Interactor should output products to Presenter")
        XCTAssert(mockProductListPresenter.presentErrorCallCount == 0, "Interactor should not output error to Presenter")
    }
}
