//
//  CZEmotionManager.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

class CZEmoticonManager {

    /// 单例
    static let shared = CZEmoticonManager()
    /// 确保使用者使用 `shared` 单例
    private init() {
        loadPackages()
    }
    /// 表情包数组
    lazy var packages = [CZEmotionPackage]()
}

// MARK: 表情包管理
private extension CZEmoticonManager {
    
    func loadPackages() {
        
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle",ofType: nil),
              let bundle = Bundle(path: path),
              let plistPath = bundle.path(forResource: "emoticons.plist",ofType: nil),
              let array = try? NSArray(contentsOf: URL(fileURLWithPath: plistPath), error: ()) as? [[String:String]],
              let model = NSArray.yy_modelArray(with: CZEmotionPackage.self, json: array) as? [CZEmotionPackage] else {
            return
        }
        
        packages += model
        
        print(packages)
    }
}
