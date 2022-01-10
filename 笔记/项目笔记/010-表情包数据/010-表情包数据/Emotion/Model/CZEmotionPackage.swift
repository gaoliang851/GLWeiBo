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
    /// 目录名称
    var directory: String?
    /// 表情数组
    lazy var emoticons = [CZEmoticon]()
    
    override var description: String {
        yy_modelDescription()
    }
}
