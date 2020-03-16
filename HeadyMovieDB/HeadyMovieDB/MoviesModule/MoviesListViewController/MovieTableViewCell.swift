//
//  MovieTableViewCell.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movie: Movie? {
        didSet{
            self.movieTitle.text = movie?.title
            self.movieReleaseYear.text = movie?.releaseDate
            if let posterImage = movie?.posterPath {
                self.moviePoster.kf.setImage(with: URL(string: APPURL.ImageBaseUrl+posterImage), placeholder: UIImage(named: "placeholderImage"))
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieTitle.text = nil
        self.movieReleaseYear.text = nil
        moviePoster.image = UIImage(named: "placeholderImage")
    }
}
