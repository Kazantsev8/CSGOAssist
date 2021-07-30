//
//  Article+CoreDataProperties.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 17.07.2021.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var text: String?
    @NSManaged public var topic: Topic?

}

extension Article : Identifiable {

}
