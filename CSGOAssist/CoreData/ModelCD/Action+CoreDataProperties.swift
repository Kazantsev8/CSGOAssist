//
//  Action+CoreDataProperties.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 17.07.2021.
//
//

import Foundation
import CoreData


extension Action {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Action> {
        return NSFetchRequest<Action>(entityName: "Action")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var topics: NSSet?
    @NSManaged public var side: Side?

}

// MARK: Generated accessors for topics
extension Action {

    @objc(addTopicsObject:)
    @NSManaged public func addToTopics(_ value: Topic)

    @objc(removeTopicsObject:)
    @NSManaged public func removeFromTopics(_ value: Topic)

    @objc(addTopics:)
    @NSManaged public func addToTopics(_ values: NSSet)

    @objc(removeTopics:)
    @NSManaged public func removeFromTopics(_ values: NSSet)

}

extension Action : Identifiable {

}
