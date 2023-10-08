//
//  Network.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

struct APIClientConfig {
    let scheme: String
    let host: String
    let sessionConfig: URLSessionConfiguration
}

protocol APIRequest {
    associatedtype Response: APIResponse
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    func handle(response: URLResponse, data: Data?) throws -> Response
}

protocol APIResponse {
    init(response: URLResponse, data: Data?) throws
}

protocol APIClientDescription {
    init(config: APIClientConfig)
    func perform(_ request: any APIRequest) async throws -> APIResponse
}

protocol URLRequestBuilderDescription {
    init(config: APIClientConfig)
    func build(with apiRequest: any APIRequest) throws -> URLRequest
}

final class Network {
    static let `default` = Network()
    let client: APIClient
    
    init() {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.timeoutIntervalForRequest = 15
        sessionConfig.httpAdditionalHeaders = [
            "X-Api-Key": Config.apiKey
        ]
        
        let clientConfig = APIClientConfig(
            scheme: "https",
            host: "newsapi.org",
            sessionConfig: sessionConfig
        )
        
        client = .init(config: clientConfig)
    }
}
