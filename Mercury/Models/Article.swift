//
//  Article.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

internal struct Article: Decodable
    {
    public let title: String
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: Date
    public let content: String?
    }

internal typealias Articles = Array<Article>
