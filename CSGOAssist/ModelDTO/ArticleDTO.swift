//
//  Article.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.06.2021.
//

import Foundation

struct ArticleDTO: Codable, Equatable {
    
    var text: String?
    var imageUrl: String?
    var topic: TopicDTO?
    
    enum CodingKeys: String, CodingKey {
        case text
        case imageUrl = "image_url"
    }
    
    init(text: String, imageUrl: String) {
        self.text = text
        self.imageUrl = imageUrl
    }
    
    init(with articleMO: Article) {
        self.text = articleMO.text
        self.imageUrl = articleMO.imageUrl
    }
    
}



