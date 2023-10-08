//
//  Requests.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

struct EverythingResponse: APIResponse {
    enum Error: Swift.Error {
        case badRequest
        case noData
    }
    
    let result: ArticlesResponse?
    
    init(response: URLResponse, data: Data?) throws {
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
            throw Error.badRequest
        }
        
        let decoder = JSONDecoder()
        guard let data else {
            result = nil
            throw Error.noData
        }
        result = try decoder.decode(ArticlesResponse.self, from: data)
    }
}

struct EverythingRequest: APIRequest {
    typealias Response = EverythingResponse
    
    var path: String {
        "/v2/everything"
    }
    
    var queryItems: [URLQueryItem]
    
    init(page: Int, pageSize: Int, query: String) {
        queryItems = [
            "page": "\(page)",
            "pageSize": "\(pageSize)",
            "q": "\(query)"
        ].map { .init(name: $0, value: $1) }
    }
    
    func handle(response: URLResponse, data: Data?) throws -> EverythingResponse {
        try .init(response: response, data: data)
    }
}

struct ArticlesResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension Article: Identifiable {
    var id: String {
        url.orEmpty
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}

