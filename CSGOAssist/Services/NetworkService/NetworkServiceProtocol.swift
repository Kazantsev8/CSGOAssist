//
//  NetworkServiceProtocol.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 05.07.2021.
//

import Foundation

//MARK: - Init protocol for Service Locator
protocol InitNetworkServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
}

//MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    
    //Interfate functions
    ///Load data from Firebase Realtime Database
    func loadData(completion: @escaping (LoadDataResponse) -> ())
    ///Load images from image url
    func loadImage(imageUrl: String, completion: @escaping (LoadImageResponse) -> ())
    ///Load timestamp from Firebase Realtime Database (check for the changes for data)
    func requestTimestamp (completion: @escaping (RequestTimeStampResponse) -> ())
    ///Load compatible version of game from Firebase Realtime Database
    func requestCompatibleVersion(completion: @escaping (RequestCompatibleVersionResponse) -> ())
}

//MARK: - Networks Maps Pass
protocol NetworkMapsPass {
    
    ///Output data
    var maps: [MapDTO]? { get }
    ///Output failure message
    ///Unused!
    var failureMessage: String? { get }
    
}

//MARK: - Network Timestamp Pass
protocol NetworkTimeStampPass {
    
    ///Output data
    var needsUpdate: Bool? { get }
    ///Output failure message
    ///Unused!
    var failureMessage: String? { get }
    
}


