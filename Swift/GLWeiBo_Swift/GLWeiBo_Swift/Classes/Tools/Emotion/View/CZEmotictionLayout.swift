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
        // xib中也可设置
        // scrollDirection = .horizontal
        
        // 在此方法中，collectionView 的大小已经确定
        guard let collectionView = collectionView else {
                return
        }
        
        itemSize = collectionView.bounds.size
        // 行间距 = 0, xib中也可设置
        //minimumLineSpacing = 0
        // 水平间距 = 0，xib中也可设置
        //minimumInteritemSpacing = 0
    }
}
