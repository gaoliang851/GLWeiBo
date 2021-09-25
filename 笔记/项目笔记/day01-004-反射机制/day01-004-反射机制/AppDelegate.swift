//
//  AppDelegate.swift
//  day01-004-反射机制
//
//  Created by mac on 2021/9/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        //命名空间包含数组和汉字可能会存在获取Class为nil的情况
        let clsName = "day01-004-反射机制.ViewController"
        
        NSLog("\(Bundle.main.infoDictionary?["CFBundleName"] ?? "")")
        
        let vcClass = NSClassFromString(clsName) as? UIViewController.Type
        
        let vc = vcClass?.init()
        
//        let vc = ViewController()
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

