//
//  UpdateOperation.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 21.07.2021.
//

import Foundation

precedencegroup OperationChaining {
    associativity: left
}
infix operator ==> : OperationChaining

@discardableResult
func ==><T: Operation>(lhs: T, rhs: T) -> T {
    rhs.addDependency(lhs)
    return rhs
}

final class UpdateFlow: UpdateFlowProtocol {
    
    private let queue = OperationQueue()
    private let networkService: NetworkServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    private let coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.networkService = coordinator.serviceLocator.networkService
        self.coreDataService = coordinator.serviceLocator.coreDataSerivce
        self.coordinator = coordinator
    }
    
    func checkState() {
        let result = coreDataService.readMaps()
        print("CheckState.readMapsResultCount = \(result.count)/CurrentVersion.timeStamp = \(String(describing: CurrentVersion.timeStamp))")
        if result == [] && CurrentVersion.timeStamp != nil {
            print("CheckState.emptyResultWhenTimeStampIsNotNil")
            CurrentVersion.timeStamp = nil
            print("CheckState.timeStampIsSetToNil")
        }
    }
    
    func start() {
        DispatchQueue.global().async {
            self.queue.maxConcurrentOperationCount = 1
            
            let requestTimeStamp = RequestTimeStampOperation(networkService: self.networkService)
            let loadData = LoadDataOperation(networkService: self.networkService, needsUpdate: nil)
            let writeMaps = WriteMapsOperation(coreDataService: self.coreDataService, maps: nil)
            let requestCompatibleVersion = RequestCompatibleVersionOperation(networkService: self.networkService)
            let readMaps = ReadMapsOperation(coreDataService: self.coreDataService)
            let endingBlock = StartApplicationOperation(coordinator: self.coordinator, maps: nil)
        
            requestTimeStamp ==> loadData ==> writeMaps ==> requestCompatibleVersion ==> readMaps ==> endingBlock

            self.queue.addOperations([requestTimeStamp, loadData, writeMaps, requestCompatibleVersion, readMaps, endingBlock], waitUntilFinished: true)
        }
    }

}


