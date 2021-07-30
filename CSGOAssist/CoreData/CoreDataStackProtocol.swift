//
//  CoreDataStackProtocol.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.07.2021.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    
    ///Context for readling from Core Data
    var readContext: NSManagedObjectContext { get }
    ///Context for writing to Core Data
    var writeContext: NSManagedObjectContext { get }
    
    func deleteMaps()
    
}
