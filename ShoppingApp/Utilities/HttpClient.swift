//
//  HttpClient.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import Foundation

// MARK: - Error Handling

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL, unknown
}

// MARK: - Networking Protocol

protocol HttpClientProtocol {
    func fetch<T:Codable>(limit: Int, skip: Int) async throws -> T
}

// MARK: - HTTP Client Implementation

class HttpClient: HttpClientProtocol {
    func fetch<T: Codable>(limit: Int, skip: Int) async throws -> T {
        
        let urlString = Constants.baseUrl + "?limit=\(limit)&skip=\(skip)"
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
}
