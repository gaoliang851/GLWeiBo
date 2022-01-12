//
//  CZEmotion.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

@objcMembers class CZEmoticon: NSObject {
    
    /// 表情类型 false - 图片表情 / true - emoji
    var type = false
    /// 表情字符串，发送给新浪微博的服务器(节约流量)
    var chs: String?
    /// 表情图片名称，用于本地图文混排
    var png: String?
    /// emoji 的十六进制编码
    var code: String?
    
    /// 表情所在的目录名称
    var directory: String?
    
    var image: UIImage? {
        
        if type {
            return nil
        }
        
        guard let directory = directory,
              let png = png else {
            return nil
        }
        
        return UIImage(named: "\(directory)/\(png)", in: Bundle.HMEmoticonBundle, compatibleWith: nil)
    }
    
    override var description: String {
        yy_modelDescription()
    }
}
