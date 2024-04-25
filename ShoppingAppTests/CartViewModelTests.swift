//
//  CartViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Sarika Lande on 23/04/24.
//

import XCTest
@testable import ShoppingApp

final class CartViewModelTests: XCTestCase {

    var cartVM: CartViewModel!

     override func setUp() {
       super.setUp()
       cartVM = CartViewModel(initialProducts: [])
     }

     override func tearDown() {
       super.tearDown()
       cartVM = nil
     }

     func test_initial_state_has_empty_cart() {
       XCTAssertEqual(cartVM.cartProducts.count, 0)
     }

     func test_cartProducts_reflects_initialProducts() {
 
         let initialProducts = [Product.init(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jp", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])]
         
         cartVM = CartViewModel(initialProducts: initialProducts)
         XCTAssertEqual(cartVM.cartProducts.count, initialProducts.count)
     }
}
