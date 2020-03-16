//
//  RESTNetworkClient.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 15/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import Alamofire

struct Request {
    let method: HTTPMethod
    let url: URL
    let parameters: [String: Any]
    
    init(method: HTTPMethod, url: URL, parameters: [String: Any] = [:]) {
        self.method = method
        self.url = url
        self.parameters = parameters
    }
}

protocol RESTNetworkClientType {
    func request(_ request: Request, completion: @escaping ([Movie]?, Error?) -> ())
}

class RESTNetworkClient: RESTNetworkClientType {
    func request(_ request: Request, completion: @escaping ([Movie]?, Error?) -> ()) {
        
        Alamofire.request(request.url , method: request.method, parameters: request.parameters).validate().responseJSON { response in
            guard response.result.isSuccess else {
                completion(nil, response.result.error)
                return
            }
            guard let data = response.data else {
                completion(nil, NetworkError.dataNotFound)
                return
            }
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                completion(movieList.movies, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        
    }
    
}
