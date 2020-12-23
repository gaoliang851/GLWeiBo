//
//  GLNavgationBar.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/23.
//

import Foundation

class GLNavgationBar: UIView {
    ///自定义的导航栏
    private lazy var navgationbar = UINavigationBar()
    /// 自定定义导航栏条目
    private lazy var item = UINavigationItem()
    /// 左边导航栏条目属性
    var leftBarButtonItem: UIBarButtonItem? {
        didSet{
            item.leftBarButtonItem = leftBarButtonItem
        }
    }
    /// 右边导航栏条目属性
    var rightBarButtonItem: UIBarButtonItem? {
        didSet {
            item.rightBarButtonItem = rightBarButtonItem
        }
    }
    /// 中间标题
    var title: String? {
        didSet {
            item.title = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var frame: CGRect {
        didSet {
            navgationbar.frame = CGRect(x: 0, y: frame.size.height - 44, width: frame.width, height: 44)
        }
    }
}
// MARK: - 设置界面
extension GLNavgationBar {
    ///设置默认的UI
    private func setupUI() {
        let defaultColor = UIColor.init(red: 246/255.0, green: 246/255.0, blue: 245/255.0, alpha: 1)
        backgroundColor = defaultColor
        addSubview(navgationbar)
        navgationbar.items = [item]
        navgationbar.setBackgroundImage(UIImage.creatImage(color: defaultColor), for: .default)
        navgationbar.shadowImage = UIImage()
    }
}
