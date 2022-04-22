//
//  OrderSummaryViewModel.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

class OrderSummaryViewModel {
    let productsOrder: [(Product, Int)]
    let dataProvider: DataProvider
    var shippingAddress: String?
    
    init(productsOrder: [(Product, Int)], dataProvider: DataProvider) {
        self.productsOrder = productsOrder
        self.dataProvider = dataProvider
    }
    
    func getProductsData() -> Data? {
        
        guard let shippingAddress = shippingAddress else {
            return nil
        }
        
        var productsJson: [[String: Any]] = []

        productsOrder.forEach { product, quantity in
            productsJson.append(["product" : product.dictionaryRepresentation(), "quantity": "\(quantity)", "shippingAddress": shippingAddress])
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: productsJson, options: .prettyPrinted)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func placeOrder(address: String,  completion: @escaping (Bool) -> Void) {
        self.shippingAddress = address
        let fileManager = FileManager.default
        do {
            let url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonURL = url.appendingPathComponent(HTTPEndPoint.Order.postOrder)
            if let productsData = getProductsData() {
                self.dataProvider.confirmOrder(url: jsonURL, data: productsData) { result in
                    switch result {
                    case .success(_):
                        completion(true)
                        print("Order Placed Successfully. File is located at URL \(jsonURL)")
                    case .failure(let error):
                        if case let .writingToFileError(description) = error {
                            print(description)
                        }
                        completion(false)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            completion(true)
        }
    }
}
