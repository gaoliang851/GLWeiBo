//
//  TestBar.swift
//  day06-001-UINavigationBar测试
//
//  Created by gaoliang on 2021/11/22.
//

import UIKit

class TestBar: UINavigationBar {
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        for subView in subviews {
//            subView.frame = bounds
//        }
//    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let oldSize = super.sizeThatFits(size)
        print("super size: \(oldSize)")
        var newSize = oldSize;
        newSize.height = frame.height
        return newSize
    }
}
