//
//  GLWeocomeView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/23.
//

import UIKit


/// 欢迎视图
class GLWelcomeView: UIView {
    
    /// 从xib加载欢迎界面
    /// - Returns: instance
    class func welcomeView() -> GLWelcomeView {
        let nib = UINib(nibName: "GLWeocomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil).last as! GLWelcomeView
        
        v.frame = UIScreen.main.bounds
        
        return v
    }
}
