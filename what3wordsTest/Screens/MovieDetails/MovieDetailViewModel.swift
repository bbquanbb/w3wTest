//
//  MovieDetailViewModel.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import Foundation

class MovieDetailViewModel {
    private let movieUseCase: MovieUseCase
    private var movieDetail: MovieDetail?
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovieDetail(movieID: Int, completion: @escaping (MovieDetail) -> Void) {
        movieUseCase.getMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.movieDetail = detail
                completion(detail)
                
            case .failure(let error):
                ErrorHandler.handleError(error as! NetworkError)
            }
        }
    }
}


