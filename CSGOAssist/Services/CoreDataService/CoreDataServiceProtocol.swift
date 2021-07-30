//
//  CoreDataServiceProtocol.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 10.07.2021.
//

import Foundation
import CoreData

//MARK: - Init Protocol for Service Locator
protocol InitCoreDataServiceProtocol {
    var coreDataSerivce: CoreDataServiceProtocol { get }
}

//MARK: - Network Service Protocol
protocol CoreDataServiceProtocol {
    
    ///Write maps to Core Data with DTO
    func writeMaps(with mapsDTO: [MapDTO])
    
    ///Read map from Core Data to DTO
    func readMaps() -> [MapDTO]
    
    ///Clear whole storage
    func clearStorage()
    
    /* UNUSED FUNCTIONS
    func sides(with predicate: NSPredicate) -> [SideDTO]
    func actions(with predicate: NSPredicate) -> [ActionDTO]
    func topics(with predicate: NSPredicate) -> [TopicDTO]
    func articles(with predicate: NSPredicate) -> [ArticleDTO]
    */
    
}

//MARK: - Core Data Maps Pass
protocol CoreDataMapsPass {
    
    ///Output data
    var maps: [MapDTO]? { get }
    
}
