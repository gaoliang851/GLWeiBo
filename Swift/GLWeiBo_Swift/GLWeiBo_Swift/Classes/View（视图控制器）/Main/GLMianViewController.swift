//
//  GLMianViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

/// 主控制器
class GLMianViewController: UITabBarController {
    
    /// 撰写添加按钮
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",
                                                             backgroundImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
    }
    
    /// 撰写按钮的点击事件
    /// @objc：允许方法以OC的消息发送机制调用方法
    @objc private func composeStatus() {
        NSLog("撰写微博")
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
    
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        // 获取子控制器的数量
        let count = CGFloat(children.count)
        // 计算每个tabbarItem的宽度，
        // -1是为了避免偶尔点击tabbar之间的空白区域导致空白ViewController展示
        let w = tabBar.bounds.width / count
        //insetBy函数，以调用CGRect为中心，扩大或缩小CGRect，正数缩小，负数扩大。
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        // 添加点击事件
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    private func setupChildControllers() {
        let controlelrsInfoDict = [[childControllerClsNameKey:"GLHomeViewController",
                                    childControllerTitleKey:"主页",
                                    childControllerImageNameKey:"home"],
                                   [childControllerClsNameKey:"GLMessageViewController",
                                    childControllerTitleKey:"消息",
                                    childControllerImageNameKey:"message_center"],
                                   [childControllerClsNameKey:"UIViewController"],//为撰写按钮占位
                                   [childControllerClsNameKey:"GLDiscoverViewController",
                                    childControllerTitleKey:"发现",
                                    childControllerImageNameKey:"discover"],
                                   [childControllerClsNameKey:"GLProfileViewController",
                                    childControllerTitleKey:"我的",
                                    childControllerImageNameKey:"profile"]]
    
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
        // 3. 设置图像，并设置以原有模式显示
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        // 4. 设置tabbar的字体
        // 4.1 设置高亮（选中）状态下的字体颜色
        vc.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.darkGray], for: .normal)
        // 4.2 如果要设置字体大小可以选在在Normal Status下,设置如果字体大小，高亮状态下设置无效
        // vc.tabBarItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 25)], for: .normal)
        // 5. 设置NavgationController
        let navgationController = GLNavigationController(rootViewController: vc)
        return navgationController
    }
}
