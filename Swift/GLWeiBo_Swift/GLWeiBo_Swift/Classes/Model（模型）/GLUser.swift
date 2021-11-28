//
//  GLUser.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import Foundation

/// 微博用户模型
@objcMembers class GLUser: NSObject {
    // 基本的数据类型 & private 不能使用KVC
    var id: Int64 = 0
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（中图），50x50像素
    var profile_image_url: String?
    /// 认证类型，-1：没有认证，
    /// 0：认证用户
    /// 2，3，5：企业认证
    /// 220：认证达人
    var verifiend_type: Int = 0
    /// 会员等级 0-6
    var mbrank: Int = 0
    
    override var description: String {
        yy_modelDescription()
    }
}
