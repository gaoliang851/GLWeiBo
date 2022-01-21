//
//  CZEmticonToolbar.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/21.
//

import UIKit

class CZEmticonToolbar: UIView {
    
    override func awakeFromNib() {
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = subviews.count
        let width = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        
        // 布局按钮
        for (i,v) in subviews.enumerated() {
            v.frame = rect.offsetBy(dx: width * CGFloat(i), dy: 0)
        }
    }
}

private extension CZEmticonToolbar {
    func setupUI() {
        // 获取表情管理器
        let manager = CZEmoticonManager.shared
        // 遍历分组名称
        for p in manager.packages {
            // 初始化按钮
            let button = UIButton(type: .custom)
            
            button.setTitle(p.groupName, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.darkGray, for: .selected)
            button.setTitleColor(.darkGray, for: .highlighted)
            button.backgroundColor = .blue
            
            button.sizeToFit()
            
            addSubview(button)
        }
    }
}
