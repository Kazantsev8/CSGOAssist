
Application CSGO:Assist

INTERNAL STORAGE
        Для работы с внутренним хранилищем в приложении используется Core Data.
        FOLDERS:
-COREDATA(FOLDER)
        CoreData(folder) - папка, содержащая в себе настройки для работы с Core Data:
            CoreDataStack.swift - файл, в котором выполнена конфигурация настроек для работы с Core Data.
            Core Data Stack:
                - core data stack реализован без использования NSPersitentContainer, сущности которые используются:
                        - NSManagedObjectModel;
                        - NSManagedObjectContext;
                        - NSPersistentStoreCoordinator;
                - приложение поддерживает 2 контекста (writeContext(контекст для записи), 
                                                                                        readContext(контекст для чтения));
                - связь между контекстами выполнена через NotificationCenter;
                - хранение данных происходит в директории .documentDirectory;
            CSGOAssist.xcdatamodeld - файл, содержащий конфигурацию модельного графа.
            XCDataModel: 
            <- - To One
            => - To Many
                Map <- => Side <- => Action <- => Topic <- => Article
            ModelCD(folder) - папка, содержащая в себе NSManagedObject-модели для работы с Core Data.
-COREDATASERVICE(FOLDER)
        CoreDataService (folder) - папка, содержащая все сущности для работы с Core Data.
            CoreDataService.swift - файл, содержащий в себе сервис для работы с Core Data.
            CoreDataServiceProtocol.swift - файл, содержащий в себе протоколы для:
                - работы с Core Data;
                - инициализации Core Data внутри Service Locator;
                - получения результата работы операций с Core Data;
            CoreDataOperations.swift - файл, содержащий в себе классы (наследники Operations) для создания атомарных операций для работы с Core Data.

    
