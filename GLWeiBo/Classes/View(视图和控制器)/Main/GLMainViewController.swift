//
//  GLMainViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

class GLMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
    }

}

//
extension GLMainViewController {
    
    /// 设置子控制器
    private func setupChildControllers() {
        var arrayM = [UIViewController]()
        arrayM.append(controller(dict: ["clsName":"GLHomeViewController","title":"首页","imageName":"home"]))
        arrayM.append(controller(dict: ["clsName":"GLMessageViewController","title":"消息","imageName":"message_center"]))
        arrayM.append(controller(dict: ["clsName":"GLDiscoverViewController","title":"发现","imageName":"discover"]))
        arrayM.append(controller(dict: ["clsName":"GLProfileViewController","title":"我","imageName":"profile"]))
        viewControllers = arrayM
    }
    
    
    /// 使用一个字典创建一个控制器
    /// - Parameter dict: 信息字典[clsName,title,imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String:String]) -> UIViewController {
        guard let clsName = dict["clsName"],
              let title = dict["title"],
              let imageName = dict["imageName"],
              //!!!
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? GLBaseViewController.Type
        else {
            return UIViewController()
        }
        
        //2. 创建子控制器
        let vc = cls.init()
        vc.title = title
        
        //3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //4. 设置tabbar的字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = GLNavigationViewController(rootViewController: vc)
        
        return nav
    }
}
