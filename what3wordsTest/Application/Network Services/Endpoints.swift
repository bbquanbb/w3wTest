//
//  Endpoints.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import Foundation

class Endpoint {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTg4NTg4MDcyNjU0M2RhODk5MTMwMzI3ODNkNjZjMCIsInN1YiI6IjY1MWFhN2MxMDcyMTY2MDBhY2I1MGU1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rIE4_fNkkN3KjndJWHNvcwOT6o5t1zl2R_zhYxdDeKk"
    
    
    static let trendingMovies = "/trending/movie/day?language=en-US"
    static let searchMovie = "/search/movie"
    static let movieDetails = "/movie"
    
    
    static func createURL(forPath path: String) -> String {
        return baseUrl + path
    }
}
