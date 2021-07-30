//
//  CoordinatorProtocol.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 26.07.2021.
//

import UIKit

//MARK: - Coordinator Interface Protocol
protocol CoordinatorProtocol {
    
    // MARK: - PROPERTIES
    /// Service Locator
    /// Contains services
    var serviceLocator: ServiceLocatorDependencies { get }
    
    /// Root View Controller for this coordinator
    var rootViewController: UINavigationController { get }
    
    //MARK: - FUNCTIONS
    /// Make app move to LoadViewController
    func toStartApplication()
    
    /// Make app move to MapsContainerController
    /// This controller contains all ViewControllers (Maps, Sides, Acitons, Topics, Articles)
    func toMapsContainerController()
    
}
