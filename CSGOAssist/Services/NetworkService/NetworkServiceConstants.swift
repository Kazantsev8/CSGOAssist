//
//  Constants.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 03.07.2021.
//

import Foundation

enum NetworkServiceConstants {
    
    ///Url to Firebase Realtime Database data for this application
    static let baseUrl: String = "https://csgoassistantru-default-rtdb.europe-west1.firebasedatabase.app/"
    ///Link to maps json
    static let mapsRequestPath: String = "maps.json"
    ///Link to timestamp json
    static let timestampRequestPath: String = "timestamp.json"
    ///Link to compatible version json
    static let compatibleVersionPath: String = "compatible_version.json"
    
}
