//
//  OrderSummaryViewModelTests.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class OrderSummaryViewModelTests: XCTestCase {
    
    var dataProvider: MockDataProvider!
    var orderSummaryViewModel: OrderSummaryViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataProvider = MockDataProvider()
        let productsOrder = [(Product(title: "Bandage", detail: "First class bandage to heal your injuries safely", id: 2, price: "15", image: "bandage", currency: "INR"), 1), (Product(title: "Pills", detail: "Can wait to be cured? try this quickly", id: 3, price: "15", image: "pills", currency: "INR"), 1), (Product(title: "Face Mask", detail: "Face Mask that covers and protects from UV all day long, Face Mask that covers and protects from UV all day long, Face Mask that covers and protects from UV all day long. Face Mask that covers and protects from UV all day long", id: 1, price: "25", image: "facemask", currency: "INR"), 1)]
        orderSummaryViewModel = OrderSummaryViewModel(productsOrder: productsOrder, dataProvider: dataProvider)
        orderSummaryViewModel.shippingAddress = ""
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOrderSummaryViewModel_WhenProductsProvided_ShouldReturnProductsData() {
        if let data = orderSummaryViewModel.getProductsData() {
            XCTAssertNotNil(data)
        } else {
            XCTFail()
        }
    }
    
    func testOrderSummaryViewModel_WhenAddressProvided_OrderShouldBePlacedSuccessfully() {
        let shippingAddress = "9-8-43/1, Kamala Devi Street, AP"
        orderSummaryViewModel.placeOrder(address: shippingAddress) { isSuccess in
            XCTAssertTrue(isSuccess)
        }
    }

}
