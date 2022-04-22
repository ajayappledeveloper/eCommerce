//
//  ProductViewModel.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

class ProductViewModel {
    var productList: ProductList?
    var storeInfo: StoreInfo?
    let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    var totalProducts: Int {
        return productList?.products.count ?? 0
    }
    
    var cartItems: [Int: Int] = [:]
    
    func getProduct(for row: Int) -> Product? {
        guard let products = productList?.products else { return nil }
        return products[row]
    }
    
    func fetchProductList(completion: @escaping (Bool) -> Void) {
        guard let url = Bundle.main.url(forResource: HTTPEndPoint.Products.getProductList, withExtension: "json") else {
            completion(false)
            return
        }
        self.dataProvider.fetchProducts(url: url) { result in
            switch result {
            case .success(let productList):
                self.productList = productList
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func fetchStoreInfo(completion: @escaping (Bool) -> Void) {
        guard let url = Bundle.main.url(forResource: HTTPEndPoint.Store.getStoreInfo, withExtension: "json") else {
            completion(false)
            return
        }
        self.dataProvider.fetchStoreDetails(url: url) { result in
            switch result {
            case .success(let storeInfo):
                self.storeInfo = storeInfo
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func addToCart(item: Product) {
        if let currentCount = cartItems[item.id] {
            cartItems[item.id] = currentCount + 1
        } else {
            cartItems[item.id] = 1
        }
    }
    
    func getOrderProducts() -> [(Product, Int)] {
        var productOrderList = [(Product, Int)]()
        guard let productList = productList else { return [] }
        
        for (productID, productCount) in cartItems {
            if let product = productList.products.first(where: { $0.id == productID }) {
                productOrderList.append((product, productCount))
            }
        }
        return productOrderList
    }
    
    func isItemAddedBefore(item: Product) -> Bool {
        guard let _ = cartItems[item.id] else { return false }
        return true
    }
    
    func clearCart() {
        cartItems = [:]
    }
}
