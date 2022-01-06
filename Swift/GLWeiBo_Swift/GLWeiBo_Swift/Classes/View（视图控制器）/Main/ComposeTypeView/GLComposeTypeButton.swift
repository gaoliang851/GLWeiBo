//
//  GLComposeTypeButton.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/6.
//

import UIKit

class GLComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 实例化一个类型按钮
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - title: 标题
    class func composeTypeButton(imageName: String,title: String) -> GLComposeTypeButton {
        let nib = UINib(nibName: "GLComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! GLComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        
        btn.titleLabel.text = title
        
        return btn
    }
}
