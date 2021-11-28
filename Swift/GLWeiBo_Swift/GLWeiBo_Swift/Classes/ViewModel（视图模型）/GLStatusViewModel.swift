//
//  GLStatusViewModel.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import Foundation


/// 单条微博的视图模型
class GLStatusViewModel {
    
    var status: GLStatus
    
    /// 单条微博的视图模型的构造器
    /// - Parameter model: 微博model
    init(model: GLStatus) {
        status = model
    }
}
