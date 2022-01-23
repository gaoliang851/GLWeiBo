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
    var code: String? {
        didSet {
            guard let code = code else {
                return
            }
            let scanner = Scanner(string: code)
            var result: UInt32 = 0
            scanner.scanHexInt32(&result)
            emoji = String(Character(UnicodeScalar(result)!))
        }
    }
    
    var emoji: String?
    
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
    
    
    /// 返回表情生成的富文本对象
    /// - Parameter font: 用于确定富文本的大小
    /// - Returns: 表情生成的富文本对象
    func imageText(font: UIFont) -> NSAttributedString {
        // 如果图像不存在就返回一个空的
        guard let image = image else {
            return NSAttributedString()
        }
        
        // 1. 创建附件
        let attachment =  NSTextAttachment()
        attachment.image = image
        
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        return NSAttributedString(attachment: attachment)
    }
    
    override var description: String {
        yy_modelDescription()
    }
}
