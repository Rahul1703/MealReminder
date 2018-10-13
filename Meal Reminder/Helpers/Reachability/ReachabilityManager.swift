//
//  ReachabilityManager.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

/// Reachability Notification
public let reachabilityChangedNotification = "reachabilityChangedNotification"

/// Reachability Status
public let reachabilityStatus              = "reachabilityStatus"

/// ReachabilityManager
open class ReachabilityManager {
    
    // MARK: - Singleton
    public static let shared = ReachabilityManager()
    
    // MARK: - Properties
    
    /// Reachability Instance
    public let reachability = Reachability()!
    
    /// Reachability Flag
    public static var isReachable: Bool {
        return ReachabilityManager.shared.connected
    }
    
    /// Checks if connected to network
    private var connected: Bool = true {
        didSet {
            let notification = Notification.init(name: Notification.Name.init(reachabilityChangedNotification), object: self, userInfo: [reachabilityStatus: connected])
            NotificationCenter.default.post(notification)
        }
    }
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Initialize
    func initialize() {
        
        // when reachable
        reachability.whenReachable = { [weak self] status in
            self?.connected = true
        }
        
        // when unreachable
        reachability.whenUnreachable = { [weak self] status in
            self?.connected = false
        }
        
        // start
        try? reachability.startNotifier()
    }
}
