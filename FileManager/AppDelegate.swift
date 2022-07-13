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
        self.window?.overrideUserInterfaceStyle = .light
        
        let loginViewController = LoginViewController(state: .signIn)//поменять на signIn для выхода
        let loginNavigationCOntroller = UINavigationController(rootViewController: loginViewController)
        loginNavigationCOntroller.tabBarItem.title = "FileManager"
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.tabBarItem.title = "Settings"
                
        tabBarController.viewControllers = [loginNavigationCOntroller, settingsNavigationController]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

