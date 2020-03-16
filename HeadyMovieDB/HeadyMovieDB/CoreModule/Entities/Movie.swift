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
    let voteCount: Int?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let originalLanguage: String?
    let originalTitle: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id = "id"
        case adult = "adult"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"

    }
}
