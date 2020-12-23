//
//  UINavgationBar+Extension.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/22.
//

import Foundation

extension UINavigationBar {
    static func getStandNavigationbarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        //iOS 13以后通过statusBarManger 获取状态栏高度
        if #available(iOS 13.0, *) {
            let statusBarManger = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            statusBarHeight = statusBarManger?.statusBarFrame.size.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let navgationbarHeight = statusBarHeight + 44
        return navgationbarHeight
    }
}
