//
//  Constants.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

enum StringConstants {
    
    enum Products {
        static let orderButtonTitle = "Order"
        static let navBarTitie = "Products"
        
        enum Alerts {
            static let itemPresentInCartTitle = "This Item already present in Cart"
            static let itemPresentInCartMessage = "Do you wish to purchase multiple items of this Product?"
            static let itemAddedToCartTitle = "Product added to Cart"
            static let itemAddedToCartMessage = "item has added to your cart successfully."
            static let ok = "Ok"
            static let cancel = "Cancel"
            static let add = "Add"
        }
    }
    
    enum OrderSummary {
        static let orderButtonTitle = "Place Order"
        static let navBarTitie = "Order Summary"
        static let addresssPlaceholder = "Please add your shipping address..."
    }
    
    enum OrderSuccess {
        static let successMessage = "Your order has been placed successfulluy. You will be receiving the items to your delivary address soon."
    }
}
