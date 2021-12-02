//
//  GLStatusPictureView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/29.
//

import UIKit

class GLStatusPictureView: UIView {
    /// 高度约束
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    var viewModel: GLStatusViewModel? {
        didSet {
            /// 更新高度
            heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            /// 循环放置图片
            for v in subviews {
                v.isHidden = true
            }
            var index = 0 //for循环的索引
            for i in viewModel?.status.pic_urls ?? [] {
                
                
                let iv = subviews[index] as! UIImageView
                
                /// 当遇到四张图时，需要跳过第三个imageView布局
                if viewModel?.status.pic_urls?.count == 4 && index == 1 {
                    index += 1
                }
                
                iv.cz_setWebImage(urlString: i.thumbnail_pic ?? "", placeholderImage: nil)
                
                iv.isHidden = false
                
                index += 1
            }
        }
    }
    
    override func awakeFromNib() {
        
        backgroundColor = superview?.backgroundColor
        
        clipsToBounds = true
        // 放置九宫格
        let rect = CGRect(x: 0,
                          y: 0,
                          width: GLStatusPictureItemWidth,
                          height: GLStatusPictureItemWidth)
        
        let count = 3
        for i in 0..<(count * count) {
            let iv = UIImageView()
            
            /**
              > 会按照图片的宽高比来拉伸
              > 要求整张图片必须填充UIImageView
              > 并且图片的宽度或者高度其中一个必须和UIImageView一样
             */
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            // 行 -> y
            let row = CGFloat(i / count)
            // 列 -> x
            let col = CGFloat(i % count)
            /// x 轴偏移量
            let xOffSet = col * (GLStatusPictureItemWidth + GLStatusPictureViewInnerMargin)
            let yOffSet = row * (GLStatusPictureItemWidth + GLStatusPictureViewInnerMargin) + GLStatusPictureViewOutterMargin
            
            iv.frame = rect.offsetBy(dx: xOffSet, dy: yOffSet)
            
            addSubview(iv)
        }
    }
}
