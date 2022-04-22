//
//  ProductsViewModelTests.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import XCTest
@testable import eCommerce

class ProductsViewModelTests: XCTestCase {
    
    var dataProvider: DataProvider!
    var productViewModel: ProductViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataProvider = MockDataProvider()
        productViewModel = ProductViewModel(dataProvider: dataProvider)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataProvider = nil
        productViewModel = nil
    }
    
    func testProductViewModel_WhenStoreInfoFetched_ShouldReturnStoreInfo() {
        //Arrange
        let user = User(name: "John", phone: "7778889991", gender: "M")
        let storeInfo = StoreInfo(storeName: "eCommerce Store", country: "India", user: user)
        
        //Act & Assert
        productViewModel.fetchStoreInfo { [unowned self] isSuccess in
            if isSuccess {
                XCTAssertNotNil(productViewModel.storeInfo)
                XCTAssertEqual(productViewModel.storeInfo?.storeName, storeInfo.storeName)
                XCTAssertEqual(productViewModel.storeInfo?.country, storeInfo.country)
                
                XCTAssertNotNil(productViewModel.storeInfo?.user)
                XCTAssertEqual(productViewModel.storeInfo?.user.name, storeInfo.user.name)
                XCTAssertEqual(productViewModel.storeInfo?.user.phone, storeInfo.user.phone)
                XCTAssertEqual(productViewModel.storeInfo?.user.gender, storeInfo.user.gender)
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewModel_WhenProductListFetched_ShouldReturnProductList() {
        //Arrange
        let products = [Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR"), Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")]
        let productsList = ProductList(products: products)
        
        //Act & Assert
        productViewModel.fetchProductList { [unowned self] isSuccess in
            if isSuccess {
                XCTAssertNotNil(productViewModel.productList)
                XCTAssertNotNil(productViewModel.productList?.products)
                XCTAssertEqual(productViewModel.productList?.products.count, productsList.products.count)
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewModel_WhenCorrectIndexProvied_ShouldReturnProduct() {
        //Arrange
        let expected = Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR")
        //Act & Assert
        productViewModel.fetchProductList { [unowned self] isSuccess in
            if isSuccess {
                let product = productViewModel.getProduct(for: 0)
                XCTAssertEqual(product?.title, expected.title)
                XCTAssertEqual(product?.id, expected.id)
                XCTAssertEqual(product?.detail, expected.detail)
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewModel_WhenAddItemsToCart_ShouldReturnCartItems() {
        //Arrange
        let item1 = Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR")
        let item2 = Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")
    
        //Act & Assert
        productViewModel.fetchProductList { [unowned self] isSuccess in
            if isSuccess {
                productViewModel.addToCart(item: item1)
                productViewModel.addToCart(item: item2)
                
                XCTAssertEqual(productViewModel.cartItems.count, 2)
                XCTAssertTrue(productViewModel.isItemAddedBefore(item: item1))
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewModel_WhenOrderProducts_ShouldReturnOrderDetails() {
        //Arrange
        let item1 = Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR")
        let item2 = Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")
    
        //Act & Assert
        productViewModel.fetchProductList { [unowned self] isSuccess in
            if isSuccess {
                productViewModel.addToCart(item: item1)
                productViewModel.addToCart(item: item2)

                let orderDetails = productViewModel.getOrderProducts()
                XCTAssertTrue(orderDetails.count == 2)
            } else {
                XCTFail()
            }
        }
    }
    
    func testProductViewModel_WhenClearCart_ShouldReturnEmptyCart() {
        //Arrange
        let item1 = Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR")
        let item2 = Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")
    
        //Act & Assert
        productViewModel.fetchProductList { [unowned self] isSuccess in
            if isSuccess {
                productViewModel.addToCart(item: item1)
                productViewModel.addToCart(item: item2)

                XCTAssertTrue(productViewModel.cartItems.count == 2)
                productViewModel.clearCart()
                XCTAssertTrue(productViewModel.cartItems.isEmpty)
            } else {
                XCTFail()
            }
        }
        
    }
    

}
