//
//  Endpoints.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import Foundation

class Endpoint {
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTg4NTg4MDcyNjU0M2RhODk5MTMwMzI3ODNkNjZjMCIsInN1YiI6IjY1MWFhN2MxMDcyMTY2MDBhY2I1MGU1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rIE4_fNkkN3KjndJWHNvcwOT6o5t1zl2R_zhYxdDeKk"

    
    // Define API paths as static properties
    static let trendingMovies = "/trending/movies"
    static let searchMovie = "/search/movie"
    static let movieDetails = "/movie/details"
    
    
    // Helper function to create a full URL
    static func createURL(forPath path: String) -> String {
        return baseURL + path
    }
}
