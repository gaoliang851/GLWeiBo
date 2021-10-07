//
//  GLVistorView.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/29.
//

import UIKit

/// 访客视图
class GLVistorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 私有控件
    /// 背后小圆圈
    private lazy var icon = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    /// 小圆圈的maskView
    private lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 小房子
    private lazy var houseIcon = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示文字
    private lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: .darkGray)
    
    /// 注册按钮
    private lazy var registerButton: UIButton = UIButton.cz_textButton("注册",
                                                             fontSize: 16,
                                                             normalColor: .orange,
                                                             highlightedColor: .darkGray,
                                                             backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    private lazy var loginButton: UIButton = UIButton.cz_textButton("登录",
                                                          fontSize: 16,
                                                          normalColor: .darkGray,
                                                          highlightedColor: .orange,
                                                          backgroundImageName: "common_button_white_disable")
}

// MARK: - 设置界面
extension GLVistorView {
    private func setupUI() {
        backgroundColor = UIColor.init(red: 236/255.0, green: 237/255.0, blue: 236/255.0, alpha: 1)
        addSubview(icon)
        addSubview(maskIconView)
        addSubview(houseIcon)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // icon的布局
        addConstraint(NSLayoutConstraint(item: icon,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: icon,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        
        // houseicon的布局
        addConstraint(NSLayoutConstraint(item: houseIcon,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: houseIcon,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // 提示文字布局
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 16))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        /// 6. a
        addConstraint(NSLayoutConstraint(item: maskIconView,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: icon,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
    }
}
