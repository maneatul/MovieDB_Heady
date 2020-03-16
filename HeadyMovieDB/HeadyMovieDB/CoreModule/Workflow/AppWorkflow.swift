//
//  AppWorkflow.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

protocol AppWorkflowType {
    func pushMovieDetailsViewController(source: UINavigationController?, movie: Movie)
}

class AppWorkflow: AppWorkflowType {
    
    let mainStoryboard: SwinjectStoryboard
    
    init(resolver: Resolver) {
        self.mainStoryboard = SwinjectStoryboard.create(name: "Main", bundle: nil,container: resolver)
    }
    
    func pushMovieDetailsViewController(source: UINavigationController?, movie: Movie){
        let movieDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsVC.viewModel.movie = movie
        source?.pushViewController(movieDetailsVC, animated: true)
    }
}
