//
//  HomeViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Sarika Lande on 22/04/24.
//

import Combine
import XCTest
@testable import ShoppingApp

final class HomeViewModelTests: XCTestCase {

    var homeVM: HomeViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        homeVM = HomeViewModel(httpClient: MockableHttpClient())
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        homeVM = nil
        cancellables = []
    }
    
    // Test initial state of products
    func test_initial_state_has_empty_products() {
       XCTAssertEqual(homeVM.products.count, 0)
    }
        
    // Test fetch products successfully
    func test_fetchNextPage_fetches_products_successfully2() async throws {
        
        let expectation = XCTestExpectation(description: "Fetched Product List")
        
        homeVM.fetchProductList()
        
        homeVM
       .$products
       .dropFirst()
       .sink { value in
               XCTAssertEqual(value.count, 30)
               expectation.fulfill()
       }
       .store(in: &cancellables)
   
#if swift(>=5.8)
    await fulfillment(of: [expectation])
#else
    wait(for: [expectation])
#endif
    }
    
    // Test retrieving a product by ID
    func test_retrieveProduct_with_existing_id_returns_product() {
      
    let mockProducts = [Product.init(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jp", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])]
        
      homeVM.products = mockProducts

      let retrievedProduct = homeVM.retriveProduct(with: 1)
      XCTAssertNotNil(retrievedProduct)
      XCTAssertEqual(retrievedProduct?.title, "iPhone 9")
    }
}
