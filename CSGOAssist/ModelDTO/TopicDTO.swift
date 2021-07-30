//
//  Topic.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.06.2021.
//

import Foundation

struct TopicDTO: Codable, Equatable {
    
    var header: String?
    var description: [ArticleDTO]?
    var action: ActionDTO?
    
    init(header: String, description: [ArticleDTO]) {
        self.header = header
        self.description = description
    }
    
    init(with topicMO: Topic) {
        self.header = topicMO.header
        let articles = topicMO.articles?.allObjects as? [Article]
        self.description = articles?.map { ArticleDTO(with: $0) }
    }
    
}

