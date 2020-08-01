//
//  AppDelegate.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!
        
    var engines: [UIApplicationDelegate] = [
        LoggingEngine.sharedInstance
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        for service in self.engines {
             _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.applicationCoordinator = ApplicationCoordinator(window: self.window!)
        self.applicationCoordinator.start()
        
        return true
    }
    
    // Reports app open from a Universal Link for iOS 9 or later
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        for service in self.engines {
            _ = service.application?(application, continue: userActivity, restorationHandler: restorationHandler)
        }
        return true
    }
    
    // Reports app open from deep link from apps which do not support Universal Links (Twitter) and for iOS8 and below
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        for service in self.engines {
            _ = service.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return true
    }
    
    // Reports app open from deep link for iOS 10 or later
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        for service in self.engines {
            _ = service.application?(app, open: url, options: options)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        for service in self.engines {
            _ = service.applicationWillResignActive?(application)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        for service in self.engines {
            _ = service.applicationDidEnterBackground?(application)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        for service in self.engines {
            _ = service.applicationWillEnterForeground?(application)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        for service in self.engines {
            _ = service.applicationDidBecomeActive?(application)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        for service in self.engines {
            _ = service.applicationWillTerminate?(application)
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        for service in self.engines {
            _ = service.application?(application, performFetchWithCompletionHandler: completionHandler)
        }
    }

}

