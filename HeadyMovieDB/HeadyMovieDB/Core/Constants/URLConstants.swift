//
//  URLConstants.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
struct APPURL {
    static let APIKEY = "99d9795a9b2dca1924a16a71156adae7"
    static let Domain = "https:api.themoviedb.org/3"
    static let ImageBaseUrl = "https://image.tmdb.org/t/p/w185"
   
    private  struct Routes {
        static let discover = "/discover/movie"
        static let search = "/search/movie"
    }
    
    static var getDiscoverMovieUrl: String {
        return Domain + Routes.discover
    }
    
    static var getSearchUrl: String {
        return Domain + Routes.search
    }
}

