//
//  ProductListWireframeTests.swift
//  ProductsViperDemoTests
//
//  Created by Avenue Brazil on 29/10/17.
//  Copyright © 2017 LucioFonseca. All rights reserved.
//

import XCTest
@testable import ProductsViperDemo

class ProductListWireframeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProductListWireframeConformsToWireframeProtocol() {
        XCTAssertTrue(ProductListWireframe.self is ProductListWireframeProtocol.Type, "Wireframe should conform to WireframeProtocols")
    }

    func testViewIsProperlyStoreAtInit() {
        //Prepare
        let mockView = MockProductListView()
        let productListWireframe = ProductListWireframe(view: mockView)
        //Verify
        XCTAssertNotNil(productListWireframe.view, "View should be stored")
    }

    func testConfigureViewControllerShouldReturnProductListView() {
        //Prepare
        let viewController = ProductListWireframe.configureViewController()
        //Verify
        XCTAssertTrue(viewController is ProductListView, "Wireframe configuration method should return a ProductListView")
    }

    func testPresentAlertShouldCallViewPresent() {
        //Exercise
        let mockView = MockProductListView()
        let productListWireframe = ProductListWireframe(view: mockView)
        productListWireframe.presentAlert(errorTitle: "", errorMessage: "")
        //Verify
        XCTAssert(mockView.presentCallCount == 1, "Calling presentAlert should call View's present Method.")

    }

    //MARK: Class Mock

    class MockProductListView: View {
        var navigationController: UINavigationController?

        var presentCallCount = 0
        func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
            presentCallCount += 1
        }
    }

    
}
