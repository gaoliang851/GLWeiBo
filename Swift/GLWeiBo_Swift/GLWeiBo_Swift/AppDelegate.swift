//
//  AppDelegate.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /// 磁盘上的配置文件地址
    static var configFilePathOnDisk: String {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (docDir as NSString).appendingPathComponent("main.json")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = GLMianViewController()
        window?.makeKeyAndVisible()
        loadAppInfo()
        return true
    }

}

// MARK: - 模拟从网络加载App信息
extension AppDelegate {
    private func loadAppInfo() {
//        DispatchQueue.main.async {
//            //1> URL
//            let url = URL(fileURLWithPath: Bundle.main.path(forResource: "main.json", ofType: nil) ?? "")
//            //2> 读取二进制
//            let data = try! Data(contentsOf: url)
//            //3> 写入磁盘
//            (data as NSData).write(toFile: AppDelegate.configFilePathOnDisk, atomically: true)
//            print("json path is \(AppDelegate.configFilePathOnDisk)")
//        }
    }
}

