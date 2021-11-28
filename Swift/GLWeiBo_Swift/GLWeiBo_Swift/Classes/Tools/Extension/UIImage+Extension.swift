//
//  UIImage+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/27.
//

import Foundation
import UIKit

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
    
    
    /// 生成头像图片
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景颜色
    ///   - lineColor: 线条颜色
    /// - Returns: 裁剪后的图片
    func cz_avatarImage(size: CGSize?, backColor: UIColor = .white, lineColor: UIColor = .lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        let ovelPath = UIBezierPath(ovalIn: rect)
        ovelPath.lineWidth = 2
        lineColor.setStroke()
        ovelPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
}
