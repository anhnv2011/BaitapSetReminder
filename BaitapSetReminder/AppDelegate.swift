//
//  AppDelegate.swift
//  BaitapSetReminder
//
//  Created by MAC on 7/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ReminderViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }



}

