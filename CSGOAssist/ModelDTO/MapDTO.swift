//
//  Map.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.06.2021.
//

import UIKit

struct MapDTO: Codable, Equatable {
    
    var name: String?
    var imageUrl: String?
    var sides: [SideDTO]?
    
    enum CodingKeys: String, CodingKey {
        case name, sides
        case imageUrl = "image_url"
    }
    
    init(name: String, imageUrl: String, sides: [SideDTO]) {
        self.name = name
        self.imageUrl = imageUrl
        self.sides = sides
    }
    
    init(with mapMO: Map) {
        self.name = mapMO.name
        self.imageUrl = mapMO.imageUrl
        let sidesFromMO = mapMO.sides?.allObjects as? [Side]
        self.sides = sidesFromMO?.map { SideDTO(with: $0) }
    }

}
