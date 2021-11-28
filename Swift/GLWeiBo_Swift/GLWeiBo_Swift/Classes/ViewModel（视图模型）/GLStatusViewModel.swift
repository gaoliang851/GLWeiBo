//
//  GLStatusViewModel.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import Foundation


/// 单条微博的视图模型
class GLStatusViewModel {
    
    /// 微博模型
    var status: GLStatus
    /// 会员图标
    var memberIcon: UIImage?
    
    /// 单条微博的视图模型的构造器
    /// - Parameter model: 微博model
    init(model: GLStatus) {
        status = model
        
        let mbrank = model.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank < 7 {
            let imageName = "common_icon_membership_level\(mbrank)"
            memberIcon = UIImage(named: imageName)
        }
    }
}
