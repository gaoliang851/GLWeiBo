//
//  AppDelegate.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/25.
//

import UIKit
import AFNetworking
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /// 磁盘上的配置文件地址
    static var configFilePathOnDisk: String {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (docDir as NSString).appendingPathComponent("main.json")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 应用程序额外设置
        setupAdditions()
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = GLMianViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    private func setupAdditions() {
        
        // > 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // > 设置用户授权显示通知
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
                print("通知授权 " + (success ? "成功":"失败"))
            }
        } else {
            // 10.0以下
            // 取得用户授权显示通知,[上方的提示条/声音/BadgeNumber]
            let notifySetting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySetting)
        }
    }
}

