//
//  ArticleView.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.urlToImage.orEmpty, encodingInvalidCharacters: false)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            
            VStack {
                HStack {
                    Text(article.title.orEmpty)
                        .font(.headline)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(article.author.orEmpty)
                    Spacer()
                    Text(article.publishedAt.orEmpty)
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
            }
        }
        .frame(maxHeight: 120)
    }
}

#Preview {
    ArticleView(
        article: .init(
            source: .init(id: "business-insider", name: "Business Insider"),
            author: "Filip De Mott",
            title: "MicroStrategy purchased another $150 million in bitcoin since August as prices tumbled",
            description: "Based on current market prices, MicroStrategy's stockpile of 158,245 bitcoins is equal to over $4.1 billion.",
            url: "https://markets.businessinsider.com/news/currencies/microstrategy-150-million-bitcoin-purchases-cryptocurrency-market-selloff-michael-saylor-2023-9",
            urlToImage: "https://i.insider.com/631133643fe7c40019e4f2fd?width=1200&format=jpeg",
            publishedAt: "2023-09-26T14:48:34Z",
            content: "Michael Saylor is facing a $100 million lawsuit for tax evasionMarco Bello/Getty Images\r\n<ul>\n<li>MicroStrategy added 5,455 bitcoins between August 1 and September 24, an SEC filing shows.</li>\n<li>S… [+1842 chars]"
        )
    )
}
