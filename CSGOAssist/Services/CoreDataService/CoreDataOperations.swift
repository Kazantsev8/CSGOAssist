//
//  CoreDataOperations.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 21.07.2021.
//

import Foundation

//MARK: - Write Maps Operation
final class WriteMapsOperation: AsyncOperation {

    private let coreDataService: CoreDataServiceProtocol
    private let _maps: [MapDTO]?

    private var maps: [MapDTO]? {
        var result: [MapDTO]?
        if let maps = _maps {
            result = maps
        } else if let dataProvider = dependencies.filter({ $0 is NetworkMapsPass}).first as? NetworkMapsPass {
            result = dataProvider.maps
        }
        return result
    }
    
    //Init
    init(coreDataService: CoreDataServiceProtocol, maps: [MapDTO]?) {
        self.coreDataService = coreDataService
        self._maps = maps
    }

    override func execute() {
        if isCancelled { return }
        switch maps {
        case .none:
            print("WriteMapsOperation.receivedNoData.cancel")
            self.isExecuting = false
            self.isFinished = true
        case .some(let mapsDTO):
            print("WriteMapsOperation.renewData.start")
            self.coreDataService.clearStorage()
            print("WriteMapsOperation.storageCleared/willWriteMaps")
            self.coreDataService.writeMaps(with: mapsDTO)
            print("WriteMapsOperation.renewData.cancel")
            self.isExecuting = false
            self.isFinished = true
        }
    }

}

//MARK: - Read Maps Operation
final class ReadMapsOperation: AsyncOperation {

    private let coreDataService: CoreDataServiceProtocol
    fileprivate var result: [MapDTO]?
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
    override func execute() {
        if isCancelled { return }
        print("ReadMapsOperation.start")
        let result = self.coreDataService.readMaps()
        print("ReadMapsOperation.readMapsCompleted")
        self.result = result
        self.isExecuting = false
        self.isFinished = true
    }

}

//MARK: - Core Data Operation - Output Parameters
extension ReadMapsOperation: CoreDataMapsPass {
    
    var maps: [MapDTO]? {
        return result
    }
    
}
