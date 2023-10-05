//
//  MovieDetailViewController.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieDetailPoster: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieDetailName: UILabel!
    @IBOutlet weak var movieDetailGenres: UILabel!
    @IBOutlet weak var movieDetailImage: UIImageView!
    var movieId: Int?
    
    var viewModel: MovieDetailViewModel! = MovieDetailViewModel(movieUseCase: DependencyContainer.shared.provideMovieUseCase())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        
        if let movieID = movieId {
            viewModel.fetchMovieDetail(movieID: movieID) { [weak self] movieDetail in
                self?.updateUIWithMovieDetail(movieDetail)
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = true
            }
        }
    }
    
    func updateUIWithMovieDetail(_ movieDetail: MovieDetail) {
        movieDetailPoster.sd_setImage(with: URL(string: movieDetail.generateImgPath(urlPath: movieDetail.posterPath ?? "")))
        movieDetailImage.sd_setImage(with: URL(string: movieDetail.generateImgPath(urlPath: movieDetail.backdropPath ?? "")))
        movieDetailName.text = movieDetail.originalTitle
        if let genres = movieDetail.genres?.compactMap({ $0.name }), !genres.isEmpty {
            movieDetailGenres.text = "Genres: \(genres.joined(separator: ", "))"
        }
    }
}
