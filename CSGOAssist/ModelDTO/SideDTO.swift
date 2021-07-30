//
//  Side.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 29.06.2021.
//

import Foundation

struct SideDTO: Codable, Equatable {
    
    var name: String?
    var imageUrl: String?
    var actions: [ActionDTO]?
    var map: MapDTO?
    
    enum CodingKeys: String, CodingKey {
        case name, actions
        case imageUrl = "image_url"
    }
    
    init(name: String, imageUrl: String, actions: [ActionDTO]) {
        self.name = name
        self.imageUrl = imageUrl
        self.actions = actions
    }
    
    init(with sideMO: Side) {
        self.name = sideMO.name
        self.imageUrl = sideMO.imageUrl
        let actionsFromMO = sideMO.actions?.allObjects as? [Action]
        self.actions = actionsFromMO?.map { ActionDTO(with: $0) }
    }

}
