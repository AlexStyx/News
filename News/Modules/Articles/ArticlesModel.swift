//
//  ArticlesModel.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation
import Combine
import Observation

@Observable
final class ArticlesState {
    enum State {
        case ready
        case loading
        case failed
    }
    
    static let initial = ArticlesState(state: .ready, articles: [], allDataLoaded: false)
    
    var state: State
    var articles: [Article]
    var allDataLoaded: Bool
    
    init(state: State, articles: [Article], allDataLoaded: Bool) {
        self.state = state
        self.articles = articles
        self.allDataLoaded = allDataLoaded
    }
}

final class ArticlesModel: ObservableObject {
    @Published var query: String = ""

    var state: ArticlesState
    
    private let client: APIClient
    
    private let pageSize = 25
    private var page: Int = 1
    private var subscriptions = Set<AnyCancellable>()

    init(client: APIClient, state: ArticlesState) {
        self.state = state
        self.client = client
        
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.touch(invalidate: true)
            }
            .store(in: &subscriptions)
    }
    
    func refresh() {
        page = 1
        touch(invalidate: true)
    }
    
    func touch(invalidate: Bool) {
        guard !query.isEmpty, state.state != .loading else { return }
        if invalidate {
            page = 1
            state.articles.removeAll()
        }
        let request = EverythingRequest(page: page, pageSize: pageSize, query: query)
        state.state = .loading
        Task {
            defer {
                state.state = .ready
            }
            let response: EverythingResponse = try await client.perform(request) as! EverythingResponse
            guard let result = response.result else {
                state.state = .failed
                return
            }
            state.articles.append(contentsOf: result.articles)
            state.allDataLoaded = result.articles.count < pageSize
            state.state = .ready
            page += 1
        }
    }
}
