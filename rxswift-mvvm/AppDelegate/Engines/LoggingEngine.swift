//
//  LoggingEngine.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit

class LoggingEngine: NSObject, UIApplicationDelegate {
    
    class var sharedInstance: LoggingEngine {
        struct Singleton {
            static let instance = LoggingEngine()
        }
        return Singleton.instance
    }
    
    private override init() {}
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        CocoaLumberjackService.shared.startLogging()
        
        return true
    }
    
}
