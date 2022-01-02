//
//  GLRefreshView.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2022/1/2.
//

import UIKit

class GLRefreshView: UIView {
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    /// 提示图片
    @IBOutlet weak var tipicon: UIImageView!
    /// 提示文字
    @IBOutlet weak var tipLabel: UILabel!
    
    class func refreshView() -> GLRefreshView {
        let nib = UINib(nibName: "GLRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0]  as! GLRefreshView
    }
}
