//
//  ScreenBuilder.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

final class ScreenBuilder {
    static func articlesScreen() -> ArticlesView {
        ArticlesView(
            model: .init(
                client: Network.default.client,
                state: .initial
            )
        )
    }
}
