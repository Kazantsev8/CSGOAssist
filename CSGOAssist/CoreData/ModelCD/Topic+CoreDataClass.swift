//
//  Topic+CoreDataClass.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 15.07.2021.
//
//

import Foundation
import CoreData

@objc(Topic)
public class Topic: NSManagedObject {

    convenience init(context: NSManagedObjectContext, with topicDTO: TopicDTO) {
        self.init(context: context)
        self.header = topicDTO.header
        let articlesFromDTO = topicDTO.description?.map { Article(context: context, with: $0) }
        guard let unwrappedArticles = articlesFromDTO else { return }
        addToArticles(NSSet(array: unwrappedArticles))
    }
    
}
