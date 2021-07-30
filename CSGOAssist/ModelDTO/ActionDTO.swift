//
//  Action.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.06.2021.
//

import Foundation

struct ActionDTO: Codable, Equatable {
    
    var name: String?
    var imageUrl: String?
    var topics: [TopicDTO]?
    var side: SideDTO?
    
    enum CodingKeys: String, CodingKey {
        case name, topics
        case imageUrl = "image_url"
    }
    
    init(name: String, imageUrl: String, topics: [TopicDTO]) {
        self.name = name
        self.imageUrl = imageUrl
        self.topics = topics
    }
    
    init(with actionMO: Action) {
        self.name = actionMO.name
        self.imageUrl = actionMO.imageUrl
        let topicsFromMO = actionMO.topics?.allObjects as? [Topic]
        self.topics = topicsFromMO?.map { TopicDTO(with: $0) }
    }

}
