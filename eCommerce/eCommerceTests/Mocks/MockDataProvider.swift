//
//  File.swift
//  eCommerceTests
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation
@testable import eCommerce

class MockDataProvider: DataProvider {
    
    func fetchStoreDetails(url: URL, completion: @escaping (Result<StoreInfo, NetworkError>) -> Void) {
        let user = User(name: "John", phone: "7778889991", gender: "M")
        let storeInfo = StoreInfo(storeName: "eCommerce Store", country: "India", user: user)
        completion(.success(storeInfo))
    }
    
    func fetchProducts(url: URL, completion: @escaping (Result<ProductList, NetworkError>) -> Void) {
        let products = [Product(title: "Mask", detail: "Mask Details", id: 1, price: "50", image: "", currency: "INR"), Product(title: "Bandage", detail: "Bandage Details", id: 2, price: "25", image: "", currency: "INR")]
        let productsList = ProductList(products: products)
        completion(.success(productsList))
    }
    
    func confirmOrder(url: URL, data: Data, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        completion(.success(true))
    }
}
