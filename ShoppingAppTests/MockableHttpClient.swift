//
//  MockableHttpClient.swift
//  ShoppingAppTests
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation
@testable import ShoppingApp

final class MockableHttpClient: HttpClientProtocol, Mockable {
    func fetch<T>(limit: Int, skip: Int) async throws -> T where T : Decodable, T : Encodable {
        return loadJSON(filename: "ProductListResponse", type: T.self)
    }
}
