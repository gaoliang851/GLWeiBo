//
//  UIBarButtonItem+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import Foundation

extension UIBarButtonItem {
    convenience init(title: String,fontSize:CGFloat = 16,target: Any?,action: Selector) {
        let btn: UIButton = UIButton.cz_textButton(title,
                                                   fontSize: fontSize,
                                                   normalColor:.darkGray,
                                                   highlightedColor: .orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
