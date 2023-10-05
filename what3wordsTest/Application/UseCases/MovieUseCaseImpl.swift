//
//  MovieUseCaseImpl.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation
import Alamofire

class MovieUseCaseImpl: MovieUseCase {
    private let networkService: NetworkService
    private let databaseService: DatabaseService
    
    init(networkService: NetworkService, databaseService: DatabaseService) {
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    
    func fetchTrendingMovies(page: Int, completion: @escaping (Result<TrendingMovie, Error>) -> Void) {
        var endpoint = Endpoint.createURL(forPath: Endpoint.trendingMovies)
        endpoint += "&page=\(page)"
        networkService.request(urlPath: endpoint) { (result: Result<TrendingMovie, Error>) in
            switch result {
            case .success(let trendingMovie):
                if let movies: [Movie] = trendingMovie.results {
                    self.databaseService.saveMovies(movies)
                }
                completion(.success(trendingMovie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            var endpoint = Endpoint.createURL(forPath: Endpoint.searchMovie)
            endpoint += "?query=\(query)"
            
            networkService.request(urlPath: endpoint) { (result: Result<TrendingMovie, Error>) in
                switch result {
                case .success(let trendingMovie):
                    completion(.success(trendingMovie.results ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            if let offlineMovies = databaseService.loadSavedMovies() {
                let filteredMovies = offlineMovies.filter { $0.title?.contains(query) == true }
                completion(.success(filteredMovies))
            } else {
                completion(.success([]))
            }
        }
    }
    
    func getMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        if let cachedMovieDetail = databaseService.loadMovieDetail(movieID: movieID) {
            completion(.success(cachedMovieDetail))
            return
        }
        
        var endpoint = Endpoint.createURL(forPath: Endpoint.movieDetails)
        endpoint += "/\(movieID)"
        networkService.request(urlPath: endpoint) { (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let detail):
                self.databaseService.saveMovieDetail(detail)
                completion(.success(detail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadOfflineMovies() -> [Movie]? {
        return databaseService.loadSavedMovies()
    }
}
