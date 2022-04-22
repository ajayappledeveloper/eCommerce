//
//  Product.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

struct ProductList: Codable {
    let products: [Product]
}

struct Product: Codable {
    let title: String
    let detail: String
    let id: Int
    let price: String
    let image: String
    let currency: String
    
    func dictionaryRepresentation() -> [String: String] {
        return ["id": "\(id)", "title": title, "detail": detail, "price": price, "currency": currency]
    }
}

struct StoreInfo: Codable {
    let storeName: String
    let country: String
    let user: User
}

struct User: Codable {
    let name: String
    let phone: String
    let gender: String
}
