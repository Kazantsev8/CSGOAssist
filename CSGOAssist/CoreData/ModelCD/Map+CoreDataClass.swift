//
//  Map+CoreDataClass.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 15.07.2021.
//
//

import Foundation
import CoreData

@objc(Map)
public class Map: NSManagedObject {

    convenience init(context: NSManagedObjectContext, with mapDTO: MapDTO) {
        self.init(context: context)
        self.name = mapDTO.name
        self.imageUrl = mapDTO.imageUrl
        let sidesFromDTO = mapDTO.sides?.map { Side(context: context, with: $0) }
        guard let unwrappedSides = sidesFromDTO else { return }
        addToSides(NSSet(array: unwrappedSides))
    }
    
}
