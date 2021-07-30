//
//  CoreDataStack.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 27.06.2021.
//

import Foundation
import CoreData

final class CoreDataStack: CoreDataStackProtocol {
    
    //MARK: - Interface property
    let readContext: NSManagedObjectContext
    let writeContext: NSManagedObjectContext
    
    //MARK: - Private properties
    private let coordinator: NSPersistentStoreCoordinator
    private let objectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "CSGOAssist", withExtension: "momd") else {
            fatalError("CoreDataStack: CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("CoreDataStack: CoreData MOMD is nil")
        }
        return model
    }()
    
    //MARK: - Initialization
    init() {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("Documents is nil")
        }
        
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("CSGOAssist.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption : true,
                        NSInferMappingModelAutomaticallyOption : true])
        } catch {
            fatalError("AddPersistentStore failure")
        }
        
        ///Binding contexts via Notifications
        self.coordinator = coordinator
        self.readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.readContext.persistentStoreCoordinator = coordinator
        self.writeContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.writeContext.persistentStoreCoordinator = coordinator
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.writeContext)
    }

    func deleteMaps() {
        let request = NSFetchRequest<Map>(entityName: "Map")
        writeContext.performAndWait {
            do {
                let maps = try request.execute()
                maps.forEach { writeContext.delete($0) }
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}

private extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            readContext.performAndWait {
                readContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}

