//
//  Coordinator.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 19.06.2021.
//

import UIKit

//MARK: - RESPONSIBILITY OF CLASS COORDINATOR - IS NAVIGATION THROUGH THE WHOLE APP. THIS CLASS CONTAINS ALL METHODS FOR PUSHING OR PRESENTING VIEW CONTROLLERS. ALSO THIS CLASS CONTAINS SERVICE LOCATOR, WHO HAS INITIALIZED ALL SERVISES NEEDED IN THIS PROJECT FOR CREATING IT ONCE IN APPLICATION.
final class Coordinator: CoordinatorProtocol {
    
    //service locator - contains services we will work with
    var serviceLocator: ServiceLocatorDependencies
    
    //root view controller - controller for starting coordinator in app delegate
    var rootViewController: UINavigationController
    
    //init
    init(rootViewController: UINavigationController, serviceLocator: ServiceLocatorDependencies) {
        self.rootViewController = rootViewController
        self.serviceLocator = serviceLocator
    }
    
    func toStartApplication() {
        DispatchQueue.main.async {
            let controller = LoadViewController(coordinator: self)
            self.rootViewController.pushViewController(controller, animated: true)
        }
    }
    
    func toMapsContainerController(maps: [MapDTO]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.rootViewController.viewControllers.count == 1 {
                let controller = MapsContainerController(coordinator: self, maps: maps)
                self.rootViewController.pushViewController(controller, animated: true)
            }
        }
    }
    
}
