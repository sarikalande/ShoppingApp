//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    var httpClient: HttpClientProtocol!
    @Published var products: [Product] = []
    
    // MARK: - Pagination Properties (Optional)
    
    private var limitValue: Int = 10
    private var skipValue: Int = 0
    
    // MARK: - Closure (Optional)
    
    var reloadTableViewClosure: (([Product]) -> Void)?
    
    // MARK: - Initialization
    
    init(httpClient: HttpClientProtocol) {
           self.httpClient = httpClient
    }
    
    // MARK: - Data Fetching
    
    func fetchProductList() {
        Task {
            
            skipValue = skipValue + 10
            let response: ProductList = try await httpClient.fetch(limit: limitValue, skip: skipValue)
                        
            self.products.append(contentsOf: response.products)
            self.reloadTableViewClosure?(response.products)
        }
    }
    
    func retriveProduct(with id: Int) -> Product? {
        return products.first(where: { $0.id == id })
    }
}
