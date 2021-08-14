//
//  CoreDataService.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 27.06.2021.
//

import Foundation
import CoreData

//MARK: - Core Data Service
final class CoreDataService {
    
    private let stack: CoreDataStackProtocol

    init(coreDataStack: CoreDataStackProtocol) {
        stack = coreDataStack
    }
    
}

//MARK: - Core Data Service - Interface
extension CoreDataService: CoreDataServiceProtocol {
    
    //MARK: Interface Functions
    ///Clear storage function is temporary.
    ///Unused!
    func clearStorage() {
        stack.deleteMaps()
    }
    
    func writeMaps(with mapsDTO: [MapDTO]) {
        let writeContext = stack.writeContext
        writeContext.performAndWait {
            let maps = mapsDTO.map { Map(context: writeContext, with: $0) }
            print(maps.count)
        }
        try? writeContext.save()
    }
    
    func readMaps() -> [MapDTO] {
        let writeContext = stack.writeContext
        var result = [MapDTO]()
        let request = NSFetchRequest<Map>(entityName: "Map")
        writeContext.performAndWait {
            guard let maps = try? request.execute() else { return }
            let mapsDTO = maps.map { MapDTO(with: $0) }
            result = mapsDTO
        }
        return result
    }
    
    ///Unused!
    /*
    func sides(with predicate: NSPredicate) -> [SideDTO] {
        let readContext = stack.readContext
        var result = [SideDTO]()
        
        let request = NSFetchRequest<Side>(entityName: "Side")
        request.predicate = predicate
        readContext.performAndWait {
            guard let sides = try? request.execute() else { return }
            result = sides.map { SideDTO(with: $0) }
        }
        return result
    }
    */

}
