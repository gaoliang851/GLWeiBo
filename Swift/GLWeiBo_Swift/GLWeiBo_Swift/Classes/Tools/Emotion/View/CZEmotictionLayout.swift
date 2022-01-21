//
//  CZEmotictionLayout.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/21.
//

import UIKit

class CZEmotictionLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        // 设定滚动方向
        // 水平方向滚动, cell 垂直方向布局
        // 垂直方向滚动, cell 水平方向布局
        scrollDirection = .horizontal
    }
}
