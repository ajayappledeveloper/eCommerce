//
//  MockJsonLoder.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class MockJsonLoderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMockJsonLoader_WhenProvidedCorrectStoreInfoFileName_ShouldReturnJson() {
        do {
            let jsonObject = try MockJsonLoader.getJsonObject(fileName: "StoreInfo")
            XCTAssertNotNil(jsonObject)
        } catch {
            XCTFail()
        }
    }
    
    func testMockJsonLoader_WhenProvidedCorrectProductsFileName_ShouldReturnJson() {
        do {
            let jsonObject = try MockJsonLoader.getJsonObject(fileName: "Products")
            XCTAssertNotNil(jsonObject)
        } catch {
            XCTFail()
        }
    }
    
    func testMockJsonLoader_WhenProvidedInCorrectStoreFileName_ShouldThrowError() {
        XCTAssertThrowsError(try MockJsonLoader.getJsonObject(fileName: "Store")) { error in
            XCTAssertEqual(error as! LoaderError, LoaderError.fileNotFound)
        }
    }

}
