//
//  UserSettings.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 20.07.2021.
//

import Foundation

//MARK: - Current Version of application (properties)
final class CurrentVersion {
    
    private enum VersionKeys: String {
        case timeStampKey
        case compatibleVersionKey
    }
    
    //Timestamp
    static var timeStamp: String? {
        get {
            return UserDefaults.standard.string(forKey: VersionKeys.timeStampKey.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = VersionKeys.timeStampKey.rawValue
            defaults.setValue(newValue, forKey: key)
        }
    }
    
    //Compatible version
    static var compatibleVersion: String? {
        get {
            return UserDefaults.standard.string(forKey: VersionKeys.compatibleVersionKey.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = VersionKeys.compatibleVersionKey.rawValue
            defaults.setValue(newValue, forKey: key)
        }
    }
    
}
