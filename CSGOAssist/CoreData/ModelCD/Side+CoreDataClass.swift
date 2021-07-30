//
//  Side+CoreDataClass.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 15.07.2021.
//
//

import Foundation
import CoreData

@objc(Side)
public class Side: NSManagedObject {

    convenience init(context: NSManagedObjectContext, with sideDTO: SideDTO) {
        self.init(context: context)
        self.name = sideDTO.name
        self.imageUrl = sideDTO.imageUrl
        let actionsFromDTO = sideDTO.actions?.map { Action(context: context, with: $0) }
        guard let unwrappedActions = actionsFromDTO else { return }
        addToActions(NSSet(array: unwrappedActions))
    }
    
}
