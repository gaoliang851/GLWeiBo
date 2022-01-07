//
//  GLComposeTypeView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/3.
//

import UIKit

class GLComposeTypeView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    /// 关闭按钮CenterX约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    /// 返回上一页按钮CenterX约束
    @IBOutlet weak var returnButtonCenterXCons: NSLayoutConstraint!
    @IBOutlet weak var returnButton: UIButton!
    lazy var buttonsInfo = [["imageName":"tabbar_compose_idea","title": "文字"],
                            ["imageName":"tabbar_compose_photo","title": "照片/视频"],
                            ["imageName":"tabbar_compose_weibo","title": "长微博"],
                            ["imageName":"tabbar_compose_lbs","title": "签到"],
                            ["imageName":"tabbar_compose_review","title": "点评"],
                            ["imageName":"tabbar_compose_more","title": "更多","actionName":"clickMore"],
                            ["imageName":"tabbar_compose_friend","title": "好友圈"],
                            ["imageName":"tabbar_compose_wbcamera","title": "微博相机"],
                            ["imageName":"tabbar_compose_music","title": "音乐"],
                            ["imageName":"tabbar_compose_shooting","title": "拍摄"],
    ]

    class func composeTypeView() -> GLComposeTypeView {
        let nib = UINib(nibName: "GLComposeTypeView", bundle: nil)
        
        /// 这个方法里面调用的 awakeForNib,
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! GLComposeTypeView
        
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }
    
    func show() {
        let vc =  UIApplication.shared.windows.filter { window in
            window.isKeyWindow
         }.first?.rootViewController
        
        vc?.view.addSubview(self)
    }
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // 调用awkeFormNib时，此时控件以及子控件的frame、bounds还都是xib中的尺寸
        // 所以调用setupUI()中去设置控件大小，如果使用freme
        setupUI()
    }
     */
    
    @objc func clickBtn() {
        logi("点击了按钮")
    }
    
    @objc func clickMore() {
        // 1. scrollview翻页
        let offset = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        
        // 2.底部按钮修改
        returnButton.isHidden = false
        
        let margin = scrollView.bounds.width / 6
        closeButtonCenterXCons.constant += margin
        returnButtonCenterXCons.constant -= margin
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}

private extension GLComposeTypeView {
    func setupUI() {
        
        //强制更新约束
        layoutIfNeeded()
        
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        /// 循环创建2个viw
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            
            addButtons(v: v, idx: i * 6)
            
            scrollView.addSubview(v)
        }
        
        
        //如果通过XIB在ScrollView内部添加了一个View用于撑起ScrollView的contentSize
        // 但是ScrollView接受不到手势事件
        scrollView.contentSize = CGSize(width: width * 2, height: scrollView.bounds.height)
        
//        print("contentSize: \(scrollView.contentSize)")
    }
    
    
    /// 向指定的view添加按钮
    /// - Parameters:
    ///   - v: 要添加按钮的view
    ///   - idx: 添加按钮从buttonsInfo开始的索引
    private func addButtons(v: UIView, idx: Int) {
        
        /// 循环创建6个按钮
        let count = 6
        for i in idx..<(idx + count) {
            if i >= buttonsInfo.count { break }
            /// 获取图片名称和title
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                  let title = dict["title"] else {
                      continue
            }
            // 创建按钮
            let btn = GLComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            // 添加到视图
            v.addSubview(btn)
            // 添加监听方法
            if let actionName = dict["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
            }
        }
        /// 定义常量
        // 按钮尺寸
        let btnSize = CGSize(width: 100, height: 100)
        // 按钮间距
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        // 开始布局, i是索引,btn是元素
        for (i,btn) in v.subviews.enumerated() {
            // 行
            //let row = CGFloat(i / 3)
            // 列
            let col = CGFloat(i % 3)
            // x,
            let X = margin + (margin + btnSize.width) * col
            let Y = i <= 2 ? 0 : (v.bounds.height - btnSize.height)
            let rect = CGRect(x: X, y: Y, width: btnSize.width, height: btnSize.height)
            btn.frame = rect
        }
    }
}
