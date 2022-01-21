//
//  CZEmotionPackage.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit
import YYModel
@objcMembers class CZEmotionPackage: NSObject {
    /// 分组名称
    var groupName: String?
    /// 背景图片名称
    var bgImageName: String?
    /// 目录名称
    var directory: String? {
        didSet {
            
            guard let directory = directory ,
                  /// 加载各个分目录下的info.plist
                  let infoPlistPath = Bundle.HMEmoticonBundle?.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                  // 加载info.plist里面的数组
                  let models = NSArray(contentsOf: URL(fileURLWithPath: infoPlistPath)) as? [[String : String]],
                  /// 数组转 CZEmoticon 模型
                  let emoticons = NSArray.yy_modelArray(with: CZEmoticon.self, json: models) as? [CZEmoticon] else {
                return
            }
            
            //遍历 emoticons 数组，设置directory 属性
            for item in emoticons {
                item.directory = directory
            }
            
            self.emoticons += emoticons
            
        }
    }
    /// 表情数组
    lazy var emoticons = [CZEmoticon]()
    
    /// 表情页的数量
    var numberOfPages: Int {
        (emoticons.count - 1) / 20 + 1
    }
    
    /// 从懒加载的表情包中，按照page 截取最多20个表情模型数组
    /// 例如 有 26个表情
    /// page == 0, 返回 0~19 个模型
    /// page == 1, 返回 20~25 个模型
    func emoticon(page: Int) -> [CZEmoticon] {
        let count = 20
        let location = page * count
        var length = count
        
        // 判断数组是否越界
        if location + length > emoticons.count {
            length = emoticons.count - location
        }
        
        let range = NSRange(location: location, length: length)
        let subArray = (emoticons as NSArray).subarray(with: range)
        return subArray as! [CZEmoticon]
    }
    
    override var description: String {
        yy_modelDescription()
    }
}
