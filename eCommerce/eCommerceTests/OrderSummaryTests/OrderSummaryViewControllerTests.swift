//
//  OrderSummaryViewControllerTests.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class OrderSummaryViewControllerTests: XCTestCase {
    
    var viewController: OrderSummaryViewController!
    var viewModel: OrderSummaryViewModel!
    var dataProvider: MockDataProvider!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataProvider = MockDataProvider()
        let productsOrder = [(Product(title: "Bandage", detail: "First class bandage to heal your injuries safely", id: 2, price: "15", image: "bandage", currency: "INR"), 1), (Product(title: "Pills", detail: "Can wait to be cured? try this quickly", id: 3, price: "15", image: "pills", currency: "INR"), 1), (Product(title: "Face Mask", detail: "Face Mask that covers and protects from UV all day long, Face Mask that covers and protects from UV all day long, Face Mask that covers and protects from UV all day long. Face Mask that covers and protects from UV all day long", id: 1, price: "25", image: "facemask", currency: "INR"), 1)]
        viewModel = OrderSummaryViewModel(productsOrder: productsOrder, dataProvider: dataProvider)
        viewController = OrderSummaryViewController(viewModel: viewModel)
        _ = viewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        viewModel = nil
        dataProvider = nil
    }
    
    func testOrderSummaryViewController_WhenShippingAddressNotProvided_OrderButtonShouldBeDisable() {
        viewController.updateOrderButton(address: nil)
        XCTAssertFalse(viewController.orderButton.isEnabled)
    }
    
    func testOrderSummaryViewController_WhenShippingAddressProvided_OrderButtonShouldBeEnabled() {
        viewController.updateOrderButton(address: "Address Provied")
        XCTAssertTrue(viewController.orderButton.isEnabled)
    }

    func testOrderSummaryViewController_WhenOrderPlaced_ShouldUpdateUI() {
        viewController.confirmOrderTapped()
        XCTAssertNotNil(viewModel.shippingAddress)
    }
}
