//
//  Article+CoreDataClass.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 15.07.2021.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {

    convenience init(context: NSManagedObjectContext, with articleDTO: ArticleDTO) {
        self.init(context: context)
        self.text = articleDTO.text
        self.imageUrl = articleDTO.imageUrl
    }
    
}
