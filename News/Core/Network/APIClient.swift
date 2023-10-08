//
//  APIClient.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

final class APIClient: APIClientDescription {
    private let session: URLSession
    private let requestBuilder: URLRequestBuilderDescription
    
    init(config: APIClientConfig) {
        session = URLSession(configuration: config.sessionConfig)
        self.requestBuilder = URLRequestBuilder(config: config)
    }
    
    func perform(_ request: any APIRequest) async throws -> APIResponse {
        let urlRequest = try requestBuilder.build(with: request)
        let (data, response) = try await session.data(for: urlRequest)
        return try request.handle(response: response, data: data)
    }
}
