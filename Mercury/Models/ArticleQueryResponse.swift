//
//  ArticleQueryResponse.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

internal struct ArticleQueryResponse: Decodable
    {
    public let status: String
    public let totalResults: Int
    public let articles: Articles
    }
