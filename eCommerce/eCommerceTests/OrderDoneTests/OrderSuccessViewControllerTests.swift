//
//  OrderSuccessViewControllerTests.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class OrderSuccessViewControllerTests: XCTestCase {
    
    var viewController: OrderSuccessViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = OrderSuccessViewController()
        _ = viewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOrderSuccessViewController_WhenPresented_ShouldUpdateUI() {
        XCTAssertEqual(viewController.messageLabel.text, StringConstants.OrderSuccess.successMessage)
    }

}
