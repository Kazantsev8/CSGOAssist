//
//  NetworkReachability.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 21.07.2021.
//

import Foundation
import SystemConfiguration
import Network

//MARK: - Network Reachability
///This class is for monitoring network connection status and type
final class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType?
    
    enum ConnectionType {
        case wifi, cellular
    }
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(path: NWPath) {
        if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
    }
}
