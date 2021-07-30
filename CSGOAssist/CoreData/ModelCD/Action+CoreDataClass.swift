//
//  Action+CoreDataClass.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 15.07.2021.
//
//

import Foundation
import CoreData

@objc(Action)
public class Action: NSManagedObject {

    convenience init(context: NSManagedObjectContext, with actionDTO: ActionDTO) {
        self.init(context: context)
        self.name = actionDTO.name
        self.imageUrl = actionDTO.imageUrl
        let topicsFromDTO = actionDTO.topics?.map { Topic(context: context, with: $0) }
        guard let unwrappedTopics = topicsFromDTO else { return }
        addToTopics(NSSet(array: unwrappedTopics))
    }
    
}
