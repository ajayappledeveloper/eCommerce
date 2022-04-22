//
//  ProductViewControllerTests.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class ProductViewControllerTests: XCTestCase {
    
    var viewController: ProductsViewController!
    var viewModel: ProductViewModel!
    var dataProvider: MockDataProvider!

    override func setUpWithError() throws {
        dataProvider = MockDataProvider()
        viewModel = ProductViewModel(dataProvider: dataProvider)
        viewController = ProductsViewController(viewModel: viewModel)
        _ = viewController.view
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        viewModel = nil
        dataProvider = nil
    }
    
    func testProductViewController_WhenFetchedStoreInfo_ShouldUpdateStoreHeaderInfo() {
        let user = User(name: "John", phone: "7778889991", gender: "M")
        let storeInfo = StoreInfo(storeName: "eCommerce Store", country: "India", user: user)
        viewController.productViewModel.fetchStoreInfo {[unowned self] isSuccess in
            if isSuccess {
                viewController.storeHeaderView.updateUI(model: viewModel.storeInfo)
                XCTAssertEqual(viewController.storeHeaderView.storeName, storeInfo.storeName)
                XCTAssertEqual(viewController.storeHeaderView.country, storeInfo.country)
                XCTAssertEqual(viewController.storeHeaderView.mobile, storeInfo.user.phone)
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewController_WhenItemAddToCart_ShouldUpdateCart() {
        let item1 = Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR")
        let item2 = Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")
        viewController.productViewModel.fetchProductList {[unowned self] isSuccess in
            if isSuccess {
                XCTAssertNotNil(viewModel.productList)
                viewController.addToCart(item: item1)
                viewController.addToCart(item: item2)
                
                XCTAssertTrue(viewModel.cartItems.count == 2)
                
            } else {
                XCTFail()
            }
        }
    }
    
}
