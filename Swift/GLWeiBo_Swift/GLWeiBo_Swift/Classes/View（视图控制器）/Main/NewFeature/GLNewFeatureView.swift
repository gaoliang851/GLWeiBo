//
//  GLNewFeatureView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/23.
//

import UIKit

/// 新特性视图
class GLNewFeatureView: UIView {

    //
    @IBOutlet weak var scrollView: UIScrollView!
    //
    @IBOutlet weak var pageControl: UIPageControl!
    //
    @IBOutlet weak var enterButton: UIButton!
    
    class func newFeatureView() -> GLNewFeatureView {
        let nib = UINib(nibName: "GLNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil).last as! GLNewFeatureView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    /// 进入微博
    @IBAction func enterStatus() {
        removeFromSuperview()
    }
    
    override func awakeFromNib() {
        /// 向scroll view 中添加新特性按钮
        /// 添加4个界面
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        // 设置content size
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(count + 1), height: rect.height)
        // 是否 回弹机制
        scrollView.bounces = false
    
        //隐藏按钮
        enterButton.isHidden = true
    }
}


extension GLNewFeatureView: UIScrollViewDelegate {
    
    // 当视图停止滚动时调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 1. 滚动到最后一屏，让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 2. 判断是不是最后一页
        if page == scrollView.subviews.count {
            print("最后一页")
            removeFromSuperview()
        }
        
        // 3. 如果是倒数第2页，显示按钮
        enterButton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    // any offset changes 调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0. 一旦滚动隐藏汗牛
        enterButton.isHidden = true
        
        // 1. 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        // 2. 设置分页控件
        pageControl.currentPage = page
        
        // 3. 分页控件隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
