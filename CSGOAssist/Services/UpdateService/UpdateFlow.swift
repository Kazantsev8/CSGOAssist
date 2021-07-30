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

class UpdateFlow {
    
    let queue = OperationQueue()
    
    let networkService: NetworkServiceProtocol
    let coreDataService: CoreDataServiceProtocol

    init(networkService: NetworkServiceProtocol,
         coreDataService: CoreDataServiceProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
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
        
            requestTimeStamp ==> loadData ==> writeMaps ==> requestCompatibleVersion

            self.queue.addOperations([requestTimeStamp, loadData, writeMaps, requestCompatibleVersion], waitUntilFinished: true)
        }
    }

}


