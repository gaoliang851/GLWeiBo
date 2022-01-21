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
    
    override var description: String {
        yy_modelDescription()
    }
}
