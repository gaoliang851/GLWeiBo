//
//  GLNavigationViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

class GLNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //当rootViewController进入时，count == 0
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.title = "第\(viewControllers.count)个"
            
            //判断控制器的类型
            if let vc = viewController as? GLBaseViewController {
                var backTitle = "返回"
                // 判断控制器的级数，只有一个子控制器的时候，显示栈底控制器的标题
                if viewControllers.count == 1 {
                    //显示首页的标题
                    backTitle = children.first?.title ?? "返回"
                }
                
                vc.navigationbar.leftBarButtonItem = UIBarButtonItem(title: backTitle, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func popToParent() {
        popViewController(animated: true)
    }
}
