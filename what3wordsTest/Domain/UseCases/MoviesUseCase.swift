//
//  MoviesUseCase.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation

protocol MovieUseCase {
    func fetchTrendingMovies(completion: @escaping (Result<TrendingMovie, Error>) -> Void)
    func searchMovies(query: String, completion: @escaping (Result<TrendingMovie, Error>) -> Void)
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}
