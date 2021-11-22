//
//  GLTitleButton.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/22.
//

import UIKit

fileprivate let padding: CGFloat = 10

class GLTitleButton: UIButton {
    
    init(title: String?) {
        super.init(frame: CGRect())
        
        // 判断title是否为nil
        if title == nil {
            setTitle("首页", for: .normal)
        } else {
            setTitle(title , for: .normal)
            // 设置图像
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        // 设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(.darkGray, for: [])
        
        // 设置大小
        sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // 重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,let imageView = imageView else {
            return
        }
        /// 可能会触发多次，为了避免重复设置需要判断
        /// titleLabel在 imageView右边才需要设置
        if titleLabel.frame.minX > imageView.frame.minX {
            let halfPadding = 0.5 * padding
            // title.x 向左移imageView.width + 半个padding
            titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width - halfPadding, dy: 0)
            // 将 imageView的 x 右移 titleLabel.width + imageView.imgae.size.width
            imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width + halfPadding, dy: 0)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        let originSize = super.sizeThatFits(size)
        
        if titleLabel != nil,imageView?.image?.size.width ?? -1 > 0 {
            var newSize = originSize
            newSize.width = newSize.width + padding
            return newSize
        }
        
        return originSize
    }
}
