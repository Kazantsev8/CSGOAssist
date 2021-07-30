//
//  Topic+CoreDataProperties.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 17.07.2021.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var header: String?
    @NSManaged public var articles: NSSet?
    @NSManaged public var action: Action?

}

// MARK: Generated accessors for articles
extension Topic {

    @objc(addArticlesObject:)
    @NSManaged public func addToArticles(_ value: Article)

    @objc(removeArticlesObject:)
    @NSManaged public func removeFromArticles(_ value: Article)

    @objc(addArticles:)
    @NSManaged public func addToArticles(_ values: NSSet)

    @objc(removeArticles:)
    @NSManaged public func removeFromArticles(_ values: NSSet)

}

extension Topic : Identifiable {

}
