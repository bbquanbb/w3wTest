//
//  TrendingMoviesViewController.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import UIKit

class TrendingMovieViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: TrendingMovieViewModel = TrendingMovieViewModel(movieUseCase: DependencyContainer.shared.provideMovieUseCase())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchIcon()
        setupTableView()
        bindViewModel()
        viewModel.fetchTrendingMovies()
    }
    
    private func addSearchIcon() {
        let searchBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped)
        )
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    @objc func searchButtonTapped() {
        navigateToSearch()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(cellClassOfNib: TrendingMovieTableViewCell.self)
        tableView.register(cellClassOfNib: LoadingTableViewCell.self)
        
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TrendingMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            viewModel.fetchTrendingMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies() + (viewModel.isLoadingMore ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < viewModel.numberOfMovies() {
            let cell = tableView.dequeueReusableCell(TrendingMovieTableViewCell.self, for: indexPath)
            
            let movie = viewModel.movie(at: indexPath.row)
            cell.selectionStyle = .none
            cell.configCell(movie: movie)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(LoadingTableViewCell.self, for: indexPath)
            cell.startLoadingAnimation()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        navigateToMovieDetail(movieId: selectedMovie.id!)
    }
}


extension TrendingMovieViewController {
    func navigateToMovieDetail(movieId: Int) {
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        movieDetailVC.movieId = movieId
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func navigateToSearch() {
        let searchViewController = SearchMovieViewController(nibName: "SearchMovieViewController", bundle: nil)
        searchViewController.viewModel = SearchMovieViewModel(movieUseCase: DependencyContainer.shared.provideMovieUseCase())
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}
