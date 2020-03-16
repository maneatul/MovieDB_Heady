//
//  MovieDetailsViewController.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit
import Kingfisher
class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var userRatings: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        title = viewModel.movie?.originalTitle
        if let ratings = viewModel.movie?.voteAverage {
            userRatings.text = "Ratings: \(ratings)"
        }
        
        if let imageUrl = viewModel.movie?.posterPath {
            posterImage.kf.setImage(with: URL(string: APPURL.ImageBaseUrl+imageUrl), placeholder: UIImage(named: "placeholderImage"))
        }
        if let date = viewModel.movie?.releaseDate {
            releaseDate.text = "Release Date: \(date)"
        }
       
        overview.text = viewModel.movie?.overview
        
    }

}
