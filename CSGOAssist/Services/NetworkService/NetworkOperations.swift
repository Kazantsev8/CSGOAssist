//
//  NetworkOperations.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 21.07.2021.
//

import Foundation

//MARK: - Request Timestamp Operation
final class RequestTimeStampOperation: AsyncOperation {
    
    private let networkService: NetworkServiceProtocol
    
    fileprivate var result: Bool?
    fileprivate var failureString: String?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    override func execute() {
        self.networkService.requestTimestamp { response in
            switch response {
            case .failure(let error):
                switch error {
                case .networkError:
                    print("(WARNING)RequestTimeStampOperation.networkError.cancel")
                    self.failureString = "NetworkError"
                    self.isExecuting = false
                    self.isFinished = true
                case .decodeError:
                    print("(WARNING)RequestTimeStampOperation.decodeError.cancel")
                    self.failureString = "DecodeError"
                    self.isExecuting = false
                    self.isFinished = true
                case .urlError:
                    print("(WARNING)RequestTimeStampOperation.urlError.cancel")
                    self.failureString = "UrlError"
                    self.isExecuting = false
                    self.isFinished = true
                }
            case .success(let newTimeStamp):
                switch CurrentVersion.timeStamp {
                case nil:
                    print("RequestTimeStampOperation.currentTimeStampIsNil")
                    self.result = true
                    print("RequestTimeStampOperation.renewingTimeStamp")
                    CurrentVersion.timeStamp = newTimeStamp
                    print("RequestTimeStampOperation.currentTimeStampIsNil.renewed")
                    self.isExecuting = false
                    self.isFinished = true
                case newTimeStamp:
                    print("RequestTimeStampOperation.equalTimeStamp")
                    self.result = false
                    self.isExecuting = false
                    self.isFinished = true
                default:
                    print("RequestTimeStampOperation.notEqualTimeStamp/defaultValue")
                    print("RequestTimeStampOperation.renewTimeStamp")
                    CurrentVersion.timeStamp = newTimeStamp
                    print("RequestTimeStampOperation.renewedTimeStamp")
                    self.result = true
                    self.isExecuting = false
                    self.isFinished = true
                }
            }
        }
    }
    
}

//MARK: - Request Timestamp Operation - Output Parameters
extension RequestTimeStampOperation: NetworkTimeStampPass {
    
    var failureMessage: String? {
        return failureString
    }
    
    var needsUpdate: Bool? {
        return result
    }
    
}

//MARK: - Load Data Operation
final class LoadDataOperation: AsyncOperation {
    
    private let networkService: NetworkServiceProtocol
    fileprivate var result: [MapDTO]?
    fileprivate var failureString: String?
    fileprivate let _needsUpdate: Bool?
    
    init(networkService: NetworkServiceProtocol, needsUpdate: Bool?) {
        self.networkService = networkService
        self._needsUpdate = needsUpdate
    }
    
    var needsUpdate: Bool? {
        var result: Bool?
        if let isPassed = _needsUpdate {
            result = isPassed
        } else if let dataProvider = dependencies.filter({ $0 is NetworkTimeStampPass}).first as? NetworkTimeStampPass {
            result = dataProvider.needsUpdate
        }
        return result
    }
    
    override func execute() {
            switch self.needsUpdate {
            case true:
                print("LoadDataOperation.updateIsNeeded")
                self.networkService.loadData { response in
                    switch response {
                    case .failure(let error):
                        switch error {
                        case .networkError:
                            print("(WARNING)LoadDataOperation.networkError")
                            self.failureString = "NetworkError"
                            self.isExecuting = false
                            self.isFinished = true
                        case .decodeError:
                            print("(WARNING)LoadDataOperation.decodeError")
                            self.failureString = "DecodeError"
                            self.isExecuting = false
                            self.isFinished = true
                        case .urlError:
                            print("(WARNING)LoadDataOperation.urlError")
                            self.failureString = "UrlError"
                            self.isExecuting = false
                            self.isFinished = true
                        }
                    case .success(let maps):
                        print("LoadDataOperation.receivedData")
                        self.result = maps
                        print("LoadDataOperation.resultIsSetToNewMaps")
                        self.isExecuting = false
                        self.isFinished = true
                    }
                }
            case false:
                print("LoadDataOperation.updateNotNeeded")
                self.result = nil
                self.isExecuting = false
                self.isFinished = true
            default:
                print("(WARNING)LoadDataOperation.updateNeededDefaultWay")
                self.result = nil
                self.isExecuting = false
                self.isFinished = true
            }
    }
    
}

//MARK: - Load Data Operation - Output Parameters
extension LoadDataOperation: NetworkMapsPass {
    
    var failureMessage: String? {
        return failureString
    }
    
    var maps: [MapDTO]? {
        return result
    }
    
}

//MARK: - Request Compatible Version Operation
final class RequestCompatibleVersionOperation: AsyncOperation {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    override func execute() {
            self.networkService.requestCompatibleVersion { request in
                switch request {
                case .failure(let error):
                    switch error {
                    case .networkError:
                        print("(WARNING)RequestCompatibleVersionOperation.networkError")
                        self.isExecuting = false
                        self.isFinished = true
                    case .decodeError:
                        print("(WARNING)RequestCompatibleVersionOperation.decodeError")
                        self.isExecuting = false
                        self.isFinished = true
                    case .urlError:
                        print("(WARNING)RequestCompatibleVersionOperation.urlError")
                        self.isExecuting = false
                        self.isFinished = true
                    }
                case .success(let newCompatibleVersion):
                    switch CurrentVersion.compatibleVersion {
                    case nil:
                        CurrentVersion.compatibleVersion = newCompatibleVersion
                        self.isExecuting = false
                        self.isFinished = true
                    case newCompatibleVersion:
                        self.isExecuting = false
                        self.isFinished = true
                    default:
                        CurrentVersion.compatibleVersion = newCompatibleVersion
                        self.isExecuting = false
                        self.isFinished = true
                    }
                }
            }
    }
    
}
