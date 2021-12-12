//
//  AppDelegate.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2021/12/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        
        let nav = UINavigationController(rootViewController: CZViewController())
        window?.rootViewController = nav;
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

