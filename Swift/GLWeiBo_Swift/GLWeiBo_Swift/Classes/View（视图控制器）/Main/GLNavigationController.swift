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
        }
        super.pushViewController(viewController, animated: animated)
    }
}
