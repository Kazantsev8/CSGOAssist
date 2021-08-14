//
//  UpdateServiceProtocol.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 11.07.2021.
//

import Foundation

protocol UpdateFlowProtocol {
    
    ///This function niles timestamp in UserDefaults when Core Data Storage is empty
    func checkState()
    ///This function starts up the update process
    func start()
    
}
