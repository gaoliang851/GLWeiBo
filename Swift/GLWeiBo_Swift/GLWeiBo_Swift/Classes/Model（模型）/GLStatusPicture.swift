//
//  GLStatusPicture.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/29.
//

import UIKit

/// 微博配图模型
@objcMembers class GLStatusPicture: NSObject {
    /// 图片地址
    var thumbnail_pic: String?
    
    override var description: String {
        yy_modelDescription()
    }
}
