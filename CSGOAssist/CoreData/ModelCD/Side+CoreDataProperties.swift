//
//  Side+CoreDataProperties.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 17.07.2021.
//
//

import Foundation
import CoreData


extension Side {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Side> {
        return NSFetchRequest<Side>(entityName: "Side")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var actions: NSSet?
    @NSManaged public var map: Map?

}

// MARK: Generated accessors for actions
extension Side {

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: Action)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: Action)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSSet)

}

extension Side : Identifiable {

}
