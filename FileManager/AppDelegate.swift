//
//  AppDelegate.swift
//  FileManager
//
//  Created by Shom on 06.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController
        self.window?.overrideUserInterfaceStyle = .light
        
        let myVewController = ViewController()
        let myNavigationController = UINavigationController(rootViewController: myVewController)

        myNavigationController.tabBarItem.title = "FileManager"

        myVewController.view.backgroundColor = .white
        
        tabBarController.viewControllers = [myNavigationController]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

