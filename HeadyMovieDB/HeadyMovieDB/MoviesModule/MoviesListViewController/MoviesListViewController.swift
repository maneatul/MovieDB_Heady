//
//  MoviesListViewController.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellHeight: CGFloat = 360
    
    var viewModel: MoviesListViewModel!
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        moviesTable.rowHeight = UITableView.automaticDimension
        moviesTable.estimatedRowHeight = cellHeight
        
        viewModel.errorMessageCallback = { errorMessage in
            DispatchQueue.main.async { [weak self] in
                if errorMessage.isEmpty {
                    self?.moviesTable.backgroundView = nil
                } else {
                    self?.moviesTable.setEmptyView(message: errorMessage)
                }
            }
        }
        
        viewModel.loaderCallback = { shouldShow in
            DispatchQueue.main.async { [weak self] in
                shouldShow ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.moviesSuccessCallback = {
            DispatchQueue.main.async { [weak self] in
                self?.moviesTable.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                viewModel.fetchMovies()
    }
    
    @IBAction func settingsButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Sort by: ", message: nil, preferredStyle: .alert)
        let popularityAction = UIAlertAction(title: "most popular", style: .default, handler: { _ in
            self.viewModel.movies = self.viewModel.movies.sorted(by: {$0.popularity! > $1.popularity!})
            self.moviesTable.reloadData()
        })
        let highRatedAction = UIAlertAction(title: "highest rated", style: .default, handler: { _ in
            self.viewModel.movies = self.viewModel.movies.sorted(by: {$0.voteAverage! > $1.voteAverage!})
            self.moviesTable.reloadData()
        })
        alert.addAction(popularityAction)
        alert.addAction(highRatedAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.movies.count == 0 {
            tableView.setEmptyView(message: viewModel.emptyStateMessage)
        } else {
            tableView.backgroundView = nil
        }
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.movie = viewModel.movies[indexPath.row]
        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushMovieDetailsView(source: navigationController, movie: viewModel.movies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.movies.count - 2
        if indexPath.row == lastElement {
            viewModel.pageCount += 1
            viewModel.fetchMovies()
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchText.count == 0 {
            viewModel.fetchMovies()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = searchBar.text!
        searchBar.endEditing(true)
        viewModel.searchMovies()
        viewModel.emptyStateMessage = ""
    }
}
