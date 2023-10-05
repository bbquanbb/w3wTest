//
//  SearchMovieViewController.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import UIKit
import Combine

class SearchMovieViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchMovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClassOfNib: TrendingMovieTableViewCell.self)
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TrendingMovieTableViewCell.self, for: indexPath)
        
        let movie = viewModel.movie(at: indexPath.row)
        cell.selectionStyle = .none
        cell.configCell(movie: movie)
        
        return cell
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchText)
    }
}
