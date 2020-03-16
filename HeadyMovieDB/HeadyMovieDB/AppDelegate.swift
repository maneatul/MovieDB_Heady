//
//  AppDelegate.swift
//  HeadyMovieDB
//
//  Created by Atul Mane on 14/03/20.
//  Copyright © 2020 Atul Mane. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    public var interModuleContainer: Container!
    public var assembler: Assembler!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        interModuleContainer = Container()
        assembler = Assembler([AppAssembly(interModuleContainer)])
        setupRootViewController()
        return true
    }
    
    func setupRootViewController() {
        var storyboard : SwinjectStoryboard
        storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: interModuleContainer)
        let moviesListViewController = storyboard.instantiateViewController(withIdentifier: "MoviesListViewController")
        let navigationController = UINavigationController(rootViewController: moviesListViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

