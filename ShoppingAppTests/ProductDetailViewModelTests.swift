//
//  ProductDetailViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Sarika Lande on 23/04/24.
//

import XCTest
@testable import ShoppingApp

final class ProductDetailViewModelTests: XCTestCase {
    
    // Mock Product object
    let mockProduct = Product.init(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jp", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])

     func test_init_with_product_sets_properties_correctly() {
       let viewModel = ProductDetailViewModel(product: mockProduct)

       XCTAssertEqual(viewModel.id, mockProduct.id)
       XCTAssertEqual(viewModel.title, mockProduct.title)
       XCTAssertEqual(viewModel.description, mockProduct.description)
       XCTAssertEqual(viewModel.price, mockProduct.price)
       XCTAssertEqual(viewModel.rating, mockProduct.rating)
       XCTAssertEqual(viewModel.brand, mockProduct.brand)
       XCTAssertEqual(viewModel.productImage?.absoluteString, "https://cdn.dummyjson.com/product-images/1/1.jpg")
       XCTAssertEqual(viewModel.thumbnail?.absoluteString, "https://cdn.dummyjson.com/product-images/1/thumbnail.jp")
     }

    func test_init_with_empty_images_sets_productImage_to_placeholder() {
       let mockProductWithoutImages = Product.init(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jp", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])
       let viewModel = ProductDetailViewModel(product: mockProductWithoutImages)

       XCTAssertEqual(viewModel.productImage?.absoluteString, "https://cdn.dummyjson.com/product-images/1/1.jpg")
     }
}
