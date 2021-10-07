//
//  UINavigationBar+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/27.
//

import Foundation

extension UINavigationBar {
    static var systemNavigationBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        //iOS 13以后通过statusBarManger 获取状态栏高度
        if #available(iOS 13.0, *) {
            let statusBarManger = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            statusBarHeight = statusBarManger?.statusBarFrame.size.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        //44为导航栏固定高度
        let navgationbarHeight = statusBarHeight + 44
        return navgationbarHeight
    }
}
