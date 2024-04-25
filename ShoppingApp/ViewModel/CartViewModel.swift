//
//  CartViewModel.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation

class CartViewModel {    

    // MARK: - Properties
    
    var cartProducts: [Product] { // Computed property to expose cart products
      return productDetails
    }

    private let productDetails: [Product] // Private storage for initial cart products

    // MARK: - Initialization
    
    init(initialProducts: [Product]) {
      self.productDetails = initialProducts
    }
}
