//
//  NewsApp.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        URLSession.shared.configuration.urlCache = URLCache(
            memoryCapacity: 30 * 1024 * 1024,
            diskCapacity: 25 * 1024 * 1024,
            directory: .downloadsDirectory
        )
        return true
    }
}
