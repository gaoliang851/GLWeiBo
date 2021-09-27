//
//  GLNavigationController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏原生的navigationBar，使用自定义的navigationBar
        navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //栈底ViewController不设置hidesBottomBarWhenPushed
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            var title = "返回"
//            // 统一设置返回按钮
//            // 第二层控制器 返回按钮显示栈底控制器的title
//            // 更深层的控制器返回按钮显示 “< 返回“
            if children.count == 1 {
                title = children.first?.title ?? "返回"
            }
            if let vc = viewController as? GLBaseViewController {
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func popToParent() {
        popViewController(animated: true)
    }
}
