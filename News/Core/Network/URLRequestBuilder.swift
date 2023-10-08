//
//  URLRequestBuilder.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

final class URLRequestBuilder: URLRequestBuilderDescription {
    enum Error: Swift.Error {
        case failedToBuildURL
    }
    private let config: APIClientConfig
    init(config: APIClientConfig) {
        self.config = config
    }
    
    func build(with apiRequest: any APIRequest) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.host
        urlComponents.path = apiRequest.path
        urlComponents.queryItems = apiRequest.queryItems
        guard let url = urlComponents.url else { throw Error.failedToBuildURL }
        let request = URLRequest(url: url)
        return request
    }
}
