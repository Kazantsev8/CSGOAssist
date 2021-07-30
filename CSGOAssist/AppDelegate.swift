//
//  AppDelegate.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 19.06.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: CoordinatorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Coordinator set
        /// navigation controller
        let navigationController = UINavigationController()
        /// service locator
        let serviceLocator = ServiceLocator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        /// starting to monitoring for network connection
        NetworkReachability.shared.startMonitoring()
        
        self.coordinator = Coordinator(rootViewController: navigationController, serviceLocator: serviceLocator)
        self.coordinator?.toStartApplication()
        
        return true
    }


}

