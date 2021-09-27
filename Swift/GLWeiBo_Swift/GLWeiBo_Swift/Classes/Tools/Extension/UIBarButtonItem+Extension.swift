//
//  UIBarButtonItem+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import Foundation

extension UIBarButtonItem {
    convenience init(title: String,fontSize:CGFloat = 16,target: Any?,action: Selector, isBack:Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title,
                                                   fontSize: fontSize,
                                                   normalColor:.darkGray,
                                                   highlightedColor: .orange)
        //如果是返回按钮，添加返回图片
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
