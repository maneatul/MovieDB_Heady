//
//  MoviesListViewModel.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import UIKit
class MoviesListViewModel {
    
    private var networkManager: NetworkManagerType
    private var workflow: AppWorkflowType
    
    var errorMessageCallback: ((String) -> Void)?
    var moviesSuccessCallback: (() -> Void)?
    var loaderCallback: ((Bool) -> Void)?
    
    var movies = [Movie]()
    var searchText = ""
    var pageCount = 1
    var emptyStateMessage = "Search for a movie" {
        didSet {
            errorMessageCallback?(emptyStateMessage)
        }
    }
    
    init(networkManager: NetworkManagerType, workflow: AppWorkflowType) {
        self.networkManager = networkManager
        self.workflow = workflow
    }
    
    func fetchMovies() {
        loaderCallback?(true)
        networkManager.fetchAllMovies(page: pageCount) {[weak self] (movies, error) in
            self?.loaderCallback?(false)
            if let error = error {
                self?.errorMessageCallback?(error.localizedDescription)
                return
            } else {
                self?.movies += movies ?? []
                if let isEmpty = self?.movies.isEmpty, isEmpty {
                    self?.emptyStateMessage = "No movies to display kindly search with different keyword"
                    self?.errorMessageCallback?(self?.emptyStateMessage ?? "")
                }
                self?.moviesSuccessCallback?()
            }
        }
    }
    
    func searchMovies() {
        loaderCallback?(true)
        networkManager.searchMovies(searchKey: searchText) {[weak self] (movies, error) in
            self?.loaderCallback?(false)
            if let error = error {
                self?.errorMessageCallback?(error.localizedDescription)
                return
            } else {
                self?.movies = movies ?? []
                if let isEmpty = self?.movies.isEmpty, isEmpty {
                    self?.emptyStateMessage = "No movies to display kindly search with different keyword"
                    self?.errorMessageCallback?(self?.emptyStateMessage ?? "")
                }
                self?.moviesSuccessCallback?()
            }
        }
    }
    
    func pushMovieDetailsView(source: UINavigationController?, movie: Movie) {
        workflow.pushMovieDetailsViewController(source: source, movie: movie)
    }
}

