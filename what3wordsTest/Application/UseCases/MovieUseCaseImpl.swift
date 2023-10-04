//
//  MovieUseCaseImpl.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation

class MovieUseCaseImpl: MovieUseCase {
    func fetchTrendingMovies(completion: @escaping (Result<TrendingMovie, Error>) -> Void) {
        <#code#>
    }
    
    func searchMovies(query: String, completion: @escaping (Result<TrendingMovie, Error>) -> Void) {
        <#code#>
    }
    
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        <#code#>
    }
    

    
}
