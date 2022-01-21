//
//  CZEmotionManager.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

extension Bundle {
    /// 表情Bunlde
    static var HMEmoticonBundle: Bundle? {
        get {
            guard let HMEmoticonBunldePath = main.path(forResource: "HMEmoticon.bundle", ofType: nil) else {
                return nil
            }
            return Bundle(path: HMEmoticonBunldePath)
        }
    }
}

class CZEmoticonManager {
    
    /// 用于缓存 表情查找
    private lazy var cache = [String: CZEmoticon]()
    /// 表情 bundle的懒加载属性
    lazy var bundle: Bundle = {
        let HMEmoticonBunldePath = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil)
        return Bundle(path: HMEmoticonBunldePath!)!
    }()

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
        
        guard let plistPath = Bundle.HMEmoticonBundle?.path(forResource: "emoticons.plist",ofType: nil),
              let array = NSArray(contentsOf: URL(fileURLWithPath: plistPath)) as? [[String:String]],
              let model = NSArray.yy_modelArray(with: CZEmotionPackage.self, json: array) as? [CZEmotionPackage] else {
            return
        }
        
        packages += model
    }
}

// MARK: - 表情字符串的处理
extension CZEmoticonManager {
    
    func emoticonString(string: String,font: UIFont) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: string)
        
        //1. 建立正则表达式、过滤所有表情文字
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        
        // 2. 匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        
        /// 这里要进行倒序遍历，否则因为替换了前边的表情，导致后边的索引发生改变
        for m in matches.reversed() {
            let r = m.range(at: 0)
            let subStr = (string as NSString).substring(with: r)
            
            if let em = CZEmoticonManager.shared.findEmoticon(string: subStr) {
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
        }
        
        // 统一设置一遍字符串属性
        attrString.addAttributes([.font:font], range: NSRange(location: 0, length: attrString.length))

        return attrString
    }
    
    /// 通过字符串查找表情对象
    /// - Parameter string: 表情字符 eg: [爱你]
    /// - Returns: 匹配的表情对象
    func findEmoticon(string: String) -> CZEmoticon? {
        
        if let em = cache[string] {
            print("缓存命中")
            return em
        }
        
        for p in packages {
            /*
            let array = p.emoticons.filter { em in
                guard let chs = em.chs else {
                    return false
                }
                return chs.elementsEqual(string)
            } */
            let array = p.emoticons.filter { $0.chs == string }
            
            if array.count > 0 {
                cache[string] = array.first
                return array.first
            }
        }
        return nil
    }
}
