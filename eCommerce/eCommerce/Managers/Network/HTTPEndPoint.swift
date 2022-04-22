//
//  HTTPEndPoint.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

enum HTTPEndPoint {
    static let baseURL: String = ""
    
    enum Products {
        static let getProductList = "Products"
    }
    
    enum Store {
        static let getStoreInfo = "StoreInfo"
    }
    
    enum Order {
        static let postOrder = "OrderDone_\(UUID().uuidString).json"
    }
}
