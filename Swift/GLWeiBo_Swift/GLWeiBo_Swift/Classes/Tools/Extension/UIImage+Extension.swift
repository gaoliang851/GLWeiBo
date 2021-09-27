//
//  UIImage+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/27.
//

import Foundation

extension UIImage {
    
    /// 通过颜色生成一张纯色图片
    /// - Parameters:
    ///   - color: color
    ///   - rect: rect
    /// - Returns: image
    static func image(color: UIColor,rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
