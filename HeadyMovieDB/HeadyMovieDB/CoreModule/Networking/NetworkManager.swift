//
//  NetworkManager.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case dataNotFound
}

protocol NetworkManagerType: class {
    func fetchAllMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> ())
    func searchMovies(searchKey: String, completion: @escaping ([Movie]?, Error?) -> ())
}

class NetworkManager: NetworkManagerType {
    
    private let network: RESTNetworkClientType
    
    init(network: RESTNetworkClientType) {
        self.network = network
    }
    
    func fetchAllMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> ()) {
        let request = Request(method: .get, url: URL(string: APPURL.getDiscoverMovieUrl)!, parameters: ["api_key": APPURL.APIKEY, "page": page])
        network.request(request, completion: completion)
    }
    
    func searchMovies(searchKey: String, completion: @escaping ([Movie]?, Error?) -> ()) {
        let request = Request(method: .get, url: URL(string: APPURL.getSearchUrl)!, parameters: ["api_key": APPURL.APIKEY,"query": searchKey])
        network.request(request, completion: completion)
    }
}
