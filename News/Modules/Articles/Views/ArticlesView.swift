//
//  ArticlesView.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import SwiftUI

struct ArticlesView: View {
    @ObservedObject var model: ArticlesModel
    var body: some View {
        NavigationView {
            List {
                ForEach(model.state.articles) { article in
                    ArticleView(article: article)
                }
                if !model.state.allDataLoaded, !model.state.articles.isEmpty {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .onAppear {
                        model.touch(invalidate: false)
                    }
                }
            }
            .refreshable {
                model.refresh()
            }
            .navigationTitle("News")
        }
        .searchable(text: $model.query)        
    }
}

#Preview {
    ScreenBuilder.articlesScreen()
}
