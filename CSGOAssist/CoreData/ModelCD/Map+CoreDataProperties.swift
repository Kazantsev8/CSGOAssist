//
//  Map+CoreDataProperties.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 17.07.2021.
//
//

import Foundation
import CoreData


extension Map {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Map> {
        return NSFetchRequest<Map>(entityName: "Map")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var sides: NSSet?

}

// MARK: Generated accessors for sides
extension Map {

    @objc(addSidesObject:)
    @NSManaged public func addToSides(_ value: Side)

    @objc(removeSidesObject:)
    @NSManaged public func removeFromSides(_ value: Side)

    @objc(addSides:)
    @NSManaged public func addToSides(_ values: NSSet)

    @objc(removeSides:)
    @NSManaged public func removeFromSides(_ values: NSSet)

}

extension Map : Identifiable {

}
