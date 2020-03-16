//
//  AppAssembly.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class AppAssembly: Assembly {
    
    private let container: Container
    
    init(_ parentContainer: Container) {
        self.container = parentContainer
    }
    
    func assemble(container: Container) {
        assembleNetworking()
        assembleMovieListViewController()
        assembleMovieDetailsViewController()
    }
}

extension AppAssembly {
    
    func assembleNetworking() {
        container.register(AppWorkflowType.self) { resolver in
            return AppWorkflow(resolver: resolver)
        }
        
        container.register(RESTNetworkClientType.self) { resolver in
            return RESTNetworkClient()
        }
        
        container.register(NetworkManagerType.self) { resolver in
            let network = resolver.resolve(RESTNetworkClientType.self)!
            return NetworkManager(network: network)
        }
        
    }
    
    func assembleMovieListViewController() {
        
        container.register(MoviesListViewModel.self) { resolver in
            guard let workFlow = resolver.resolve(AppWorkflowType.self) else { fatalError("Could not resolve work flow") }
            let network = resolver.resolve(NetworkManagerType.self)!
            return MoviesListViewModel(networkManager: network, workflow: workFlow)
        }
        
        container.storyboardInitCompleted(MoviesListViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(MoviesListViewModel.self)
        }
    }
    
    func assembleMovieDetailsViewController() {
        container.register(MovieDetailsViewModel.self) { resolver in
            return MovieDetailsViewModel()
        }
        container.storyboardInitCompleted(MovieDetailsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(MovieDetailsViewModel.self)
        }
    }
    
}
