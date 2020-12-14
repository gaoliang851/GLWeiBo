//
//  AppDelegate.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = GLMainViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

