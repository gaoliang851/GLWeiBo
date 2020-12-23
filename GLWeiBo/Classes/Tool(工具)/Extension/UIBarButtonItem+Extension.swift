//
//  UIBarButtonItem+Extension.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/23.
//

import Foundation

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize,默认16号
    ///   - target: targat
    ///   - action: action
    ///   - isBack: 是否是返回按钮，如果是加上箭头
    convenience init(title: String,fontSize:CGFloat = 16,target: AnyObject?,action :Selector,isBack: Bool) {
        let btn :UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted" ), for: .highlighted)
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
}
