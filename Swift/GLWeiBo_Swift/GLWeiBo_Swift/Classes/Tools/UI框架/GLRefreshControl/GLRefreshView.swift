//
//  GLRefreshView.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2022/1/2.
//

import UIKit

class GLRefreshView: UIView {
    
    /// 父视图的高度
    var parentViewHeight: CGFloat = 0
    
    /// 刷新状态
    /// iOS系统中 UIView 封装的旋转动画
    /// 默认是顺时针旋转,并且就近原则(顺时针一样近，就顺时针旋转)
    /// 要实现同方向旋转，需要调整一个非常小的数字
    /// 如果要实现360 旋转,需要核心动画 CABaseAnimation
    var refreshState: GLRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                tipLabel?.text = "继续使劲拉..."
                tipicon?.isHidden = false
                indicator?.stopAnimating()
                UIView.animate(withDuration: 0.25) {
                    self.tipicon?.transform = CGAffineTransform.identity
                }
            case .Pulling:
                tipLabel?.text = "放手就刷新..."
                UIView.animate(withDuration: 0.25) {
                    self.tipicon?.transform = CGAffineTransform(rotationAngle: .pi - 0.001)
                }
            case .WillRefresh:
                tipLabel?.text = "正在刷新中..."
                
                // 隐藏icon
                tipicon?.isHidden = true
                // 显示指示器
                indicator?.startAnimating()
            }
        }
    }
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    /// 提示图片
    @IBOutlet weak var tipicon: UIImageView?
    /// 提示文字
    @IBOutlet weak var tipLabel: UILabel?
    
    class func refreshView() -> GLRefreshView {
        let nib = UINib(nibName: "GLRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0]  as! GLRefreshView
    }
    
    class func humanRefreshView() -> GLRefreshView {
        let nib = UINib(nibName: "GLHumanRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0]  as! GLRefreshView
    }
}
