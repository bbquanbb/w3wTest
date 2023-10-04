//
//  TrendingMovie.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation

struct TrendingMovie: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
