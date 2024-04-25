//
//  Product.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation

struct ProductList: Codable {
    var products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let id: Int16
    let title, description: String
    var price: Double
    let discountPercentage, rating: Double
    let brand, category: String
    let thumbnail: String
    let images: [String]
//    let quantity: Int16
}
