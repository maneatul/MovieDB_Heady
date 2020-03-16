//
//  Movie.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    let pageNumber: Int?
    let totalResults: Int?
    let totalPages: Int?
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"

    }
}

struct Movie: Decodable {
    let popularity: Double?
    let vote_count: Int?
    let poster_path: String?
    let id: Int?
    let adult: Bool?
    let original_language: String?
    let original_title: String?
    let title: String?
    let posterUrl: String?
    let vote_average: Double?
    let overview: String?
    let release_date: String?
}
