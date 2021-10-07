//
//  GLVistorView.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/29.
//

import UIKit

/// 访客视图
class GLVistorView: UIView {
    /// 视图属性字典
    /// key: imageName,message
    /// 注意: 首页视图 imageName传入""
    var vistorInfo: [String:String]? {
        didSet {
            // 取出imageName和message
            guard let imageName = vistorInfo?["imageName"],
                  let message = vistorInfo?["message"] else {
                return
            }
            
            // 如果imageName的长度为0,则说明是首页传入
            // 不用再做其他的设置
            if imageName.count == 0 {
                startAnimation()
                return
            }
            
            icon.image = UIImage(named: imageName)
            tipLabel.text = message
            // 其他页面不需要小房子图标、遮罩图标
            houseIcon.isHidden = true
            maskIconView.isHidden = true
        }
    }
    
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
        //1> 修改背景颜色
        backgroundColor = UIColor.init(red: 236/255.0, green: 237/255.0, blue: 236/255.0, alpha: 1)
        
        //2> 懒加载子控件并添加到视图
        addSubview(icon)
        addSubview(maskIconView)
        addSubview(houseIcon)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 让文本居中显示
        tipLabel.textAlignment = .center
        
        // 布局子控件
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
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
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
    
    
    /// 旋转图标动画
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        
        // 动画完成不删除,如果 iconView被释放,动画会一起销毁
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层
        icon.layer.add(anim, forKey: nil)
    }
}
