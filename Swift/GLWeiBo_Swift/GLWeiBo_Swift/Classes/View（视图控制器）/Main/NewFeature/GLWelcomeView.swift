//
//  GLWeocomeView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/23.
//

import UIKit
import SDWebImage

/// 欢迎视图
class GLWelcomeView: UIView {
    
    // 头像
    @IBOutlet weak var iconView: UIImageView!
    // 欢迎回来label
    @IBOutlet weak var tipLabel: UILabel!
    // 底部约束
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    /// 从xib加载欢迎界面
    /// - Returns: instance
    class func welcomeView() -> GLWelcomeView {
        
        let nib = UINib(nibName: "GLWeocomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil).last as! GLWelcomeView
        
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override func awakeFromNib() {
        // 加载头像
        guard let urlString = GLNetworkManager.shared.userAccount.avatar_large,
              let url = URL(string: urlString) else {
                 return
        }
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"), options: [], context: nil)
        
        // 设置圆角
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
    }
    
    
    /// 视图被添加到window上，表示视图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // 视图是使用自动布局来设置的，只是设置了约束
        // - 当视图被添加到窗口上时，根据父视图的大小，计算约束值，更新控件位置
        // - layoutIfNeed 会直接按照当前的约束直接更新控件的位置
        // - 执行之后，控件所在位置，就是XIB中布局的位置
        // - 此处打断点，控件的Frame已经计算好了
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        
        // 如果控件们的frame 还没计算好！所有的约束会一起动画！
        UIView.animate(withDuration: 1.5, // 动画时长
                       delay: 0, // 延迟执行
                       usingSpringWithDamping: 0.7, // 弹性
                       initialSpringVelocity: 0, // 初始速度
                       options: []) {
            // 更新约束
            self.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 1.0) {
                self.tipLabel.alpha = 1
            } completion: { _ in
                self.removeFromSuperview()
            }
        }

        
    }
}
