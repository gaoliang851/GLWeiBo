//
//  GLMeiTuanRefreshView.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2022/1/3.
//

import UIKit

class GLMeiTuanRefreshView: GLRefreshView {
    
    /// 背景房子图标
    @IBOutlet weak var buildIcon: UIImageView!
    /// 地球图标
    @IBOutlet weak var earthIcon: UIImageView!
    /// 袋鼠
    @IBOutlet weak var kangarooIcon: UIImageView!
    
    override var parentViewHeight: CGFloat {
        didSet {
            if parentViewHeight < 23 {
                return
            }
            
            var scale: CGFloat
            
            if parentViewHeight > 126 {
                scale = 1
            } else {
                scale = 1 - ((126 - parentViewHeight) / (126 - 23))
            }
            
            kangarooIcon.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    
    class func instanceView() -> GLMeiTuanRefreshView {
        let nib = UINib(nibName: "GLMeiTuanRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! GLMeiTuanRefreshView
    }
    
    override func awakeFromNib() {
        /// 房子的动画
        let bImage1 = UIImage(named: "icon_building_loading_1") ?? UIImage()
        let bImage2 = UIImage(named: "icon_building_loading_2") ?? UIImage()
        
        buildIcon.image = UIImage.animatedImage(with: [bImage1,bImage2], duration: 0.5)
        
        // 地球转动
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = -2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        anim.isRemovedOnCompletion = false
        
        earthIcon.layer.add(anim, forKey: nil)
        
        // 袋鼠动画
        let KImage1 = UIImage(named: "icon_small_kangaroo_loading_1") ?? UIImage()
        let KImage2 = UIImage(named: "icon_small_kangaroo_loading_2") ?? UIImage()
        kangarooIcon.image = UIImage.animatedImage(with: [KImage1,KImage2], duration: 0.25)
    
        // 1. 设置锚点
        kangarooIcon.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 2. 设置 center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 35
        kangarooIcon.center = CGPoint(x: x, y: y)
        
        kangarooIcon.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
}
