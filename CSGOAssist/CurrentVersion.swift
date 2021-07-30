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
    
    //This property contains actual update-time in server data
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
    
    //This property contains actual compatible game version
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
