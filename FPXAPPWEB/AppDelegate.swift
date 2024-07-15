//
//  AppDelegate.swift
//  FPXAPPWEB
//
//  Created by Felix Holzapfel on 14.07.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("App did finish launching")
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("Configuring scene session")
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("Scene sessions discarded")
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Additional Lifecycle Methods

    func applicationWillResignActive(_ application: UIApplication) {
        print("App will resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminate")
    }
}
