//
//  AppDelegate.swift
//  streaming
//
//  Created by Mark Boleigha on 30/09/2020.
//  Copyright © 2020 quacklabs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setRootView(controller: Navigation.shared)
        return true
    }
}

extension AppDelegate {
    func setRootView(controller: UIViewController, completion: (() -> Void)? = nil) {
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
        completion?()
    }
}

