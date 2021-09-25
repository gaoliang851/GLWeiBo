//
//  AppDelegate.swift
//  反射机制
//
//  Created by mac on 2021/9/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let clsName = "反射机制.ViewController"
        
        let vcClass = NSClassFromString(clsName) as? UIViewController.Type
        
        let vc = vcClass?.init()
        
//        let vc = ViewController()
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

