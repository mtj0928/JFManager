//
//  AppDelegate.swift
//  JFManager
//
//  Created by 松本淳之介 on 2018/11/30.
//  Copyright © 2018 Kusumoto Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
}

// MARK: Methods

extension AppDelegate {

    private func setupWindow() {
        let masterViewController = MasterBuilder.buildDefault()
        let splitViewController = UISplitViewController()
        let navigtionController = UINavigationController()
        navigtionController.viewControllers = [SettingBuilder.defaultBuilde(navigtionController)]

        splitViewController.viewControllers = [masterViewController, navigtionController]
        splitViewController.preferredDisplayMode = .allVisible

        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}
