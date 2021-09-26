//
//  GLMianViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

/// 主控制器
class GLMianViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
    }
}

// extension类似于OC中的分类,在 Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个extension中
// 便于维护代码
// 注意：和OC的分类一样，extension中不能定义属性
// MARK: - 设置界面

//常量：字典中类名的key
fileprivate let childControllerClsNameKey = "clsName"
//常量：字典中标题的key
fileprivate let childControllerTitleKey = "title"
//常量：字典中图片名称的key
fileprivate let childControllerImageNameKey = "imageName"

extension GLMianViewController {
    
    /// 设置所有子控制器
    private func setupChildControllers() {
        let controlelrsInfoDict = [[childControllerClsNameKey:"GLHomeViewController",
                                    childControllerTitleKey:"主页",
                                    childControllerImageNameKey:""]]
    
        var arrayM = [UIViewController]()
        for dict in controlelrsInfoDict {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    
    /// 根据字典创建一个子控制器
    /// - Parameter dict: 信息字典 [clsName,title,imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String: String]) -> UIViewController {
        // 1. 获取字典内容，如果没有获取到就返回一个默认的UIViewController
        guard let clsName = dict[childControllerClsNameKey],
              let title = dict[childControllerTitleKey],
              let imageName = dict[childControllerImageNameKey],
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
            return UIViewController()
        }
        // 2.创建控制器，设置title和image
        let vc = cls.init()
        vc.title = title
        let navgationController = GLNavigationController(rootViewController: vc)
        return navgationController
    }
}
