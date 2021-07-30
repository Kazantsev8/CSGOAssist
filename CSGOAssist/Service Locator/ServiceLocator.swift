//
//  ServiceLocator.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 19.06.2021.
//

import Foundation

//MARK: - Service Locator Dependencies
protocol ServiceLocatorDependencies: InitCoreDataServiceProtocol,
                                     InitNetworkServiceProtocol
{}

//MARK: - Service Locator
final class ServiceLocator: ServiceLocatorDependencies {
    
    //This class has only one instace of each service in application
    ///Initializing Core Data Service
    var coreDataSerivce: CoreDataServiceProtocol = CoreDataService(coreDataStack: CoreDataStack())
    ///Initializing Network Service
    var networkService: NetworkServiceProtocol = NetworkService()
    
}
