//
//  DemoLabel.swift
//  day01-002-懒加载
//
//  Created by mac on 2021/9/24.
//

import UIKit

class DemoLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI () {
        NSLog("测试项目")
    }

}
