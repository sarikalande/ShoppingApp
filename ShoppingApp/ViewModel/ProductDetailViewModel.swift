//
//  ProductDetailViewModel.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation

struct ProductDetailViewModel {
    
    // MARK: - Properties
    
    var id: Int16
    var productImage: URL?
    var title: String
    var description: String
    var thumbnail: URL?
    let price: Double
    let rating: Double
    let brand: String
   // let quantity: Int16
    let productDetails: Product
    
    // MARK: - Initialization
    
    init(product: Product) {
        self.productDetails = product
        self.id = product.id
        self.title = product.title 
        self.description = product.description 
        self.price = product.price
        self.rating = product.rating
        self.productImage = URL(string: product.images.first ?? "ImagePlaceholder")
        self.thumbnail = URL(string: product.thumbnail)
        self.brand = product.brand
        //self.quantity = product.quantity
    }
    
    // MARK: - Action Methods
    
    func addToCart() {
        CoreDataManager.shared.addToCart(selectedProduct: self)
    }
}

