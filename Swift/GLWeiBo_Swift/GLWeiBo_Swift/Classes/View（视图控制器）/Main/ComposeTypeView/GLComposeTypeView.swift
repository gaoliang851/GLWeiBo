//
//  GLComposeTypeView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/3.
//

import UIKit

class GLComposeTypeView: UIView {
    
    lazy var buttonsInfo = [["imageName":"tabbar_compose_idea","title": "文字"],
                            ["imageName":"tabbar_compose_photo","title": "照片/视频"],
                            ["imageName":"tabbar_compose_weibo","title": "长微博"],
                            ["imageName":"tabbar_compose_lbs","title": "签到"],
                            ["imageName":"tabbar_compose_review","title": "点评"],
                            ["imageName":"tabbar_compose_more","title": "更多"],
                            ["imageName":"tabbar_compose_friend","title": "好友圈"],
                            ["imageName":"tabbar_compose_wbcamera","title": "微博相机"],
                            ["imageName":"tabbar_compose_music","title": "音乐"],
                            ["imageName":"tabbar_compose_shooting","title": "拍摄"],
    ]

    class func composeTypeView() -> GLComposeTypeView {
        let nib = UINib(nibName: "GLComposeTypeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! GLComposeTypeView
        
        return v
    }
    
    func show() {
        let vc =  UIApplication.shared.windows.filter { window in
            window.isKeyWindow
         }.first?.rootViewController
        
        self.frame = UIScreen.main.bounds
        
        vc?.view.addSubview(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @objc func clickBtn() {
        logi("点击了按钮")
    }
    
    @IBAction func close(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}

private extension GLComposeTypeView {
    func setupUI() {
        //let btn = GLComposeTypeButton.composeTypeButton(imageName: "tabbar_compose_music", title: "test")
        //btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        
        //addSubview(btn)
        
//        addSubview()
    }
}
