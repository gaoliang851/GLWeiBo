//
//  GLMainViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

class GLMainViewController: UITabBarController {
    
    private lazy var composeButton: UIButton = UIButton.cz_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
    

    }
    /// 撰写微博按钮点击事件
    @objc private func clickComposedButton() {
        GLLogTag()
    }
    
    override func viewDidLayoutSubviews() {
        
    }

}
//extension 类似于OC中的分类，在Swift中还可以用来切分代码块
//可以把功能相近的函数，放在一个extension中
//便于代码维护
// 注意：和OC的分类一样，extension中不能定义属性
// MARK: - 设置界面
extension GLMainViewController {
    
    /// 设置撰写微博按钮
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        //计算按钮宽度，将向内缩进的宽度减少，能够让按钮的宽度变大，盖住容错点，防止穿帮！
        let w = CGFloat(tabBar.bounds.size.width / 5 - 1) 
        //CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: w * 2, dy: 0)
        //按钮监听方法
        composeButton.addTarget(self, action: #selector(clickComposedButton), for: .touchUpInside)
    }
    
    /// 设置子控制器
    private func setupChildControllers() {
        let array = [
            ["clsName":"GLHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"GLMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"UIViewController"],
            ["clsName":"GLDiscoverViewController","title":"发现","imageName":"discover"],
            ["clsName":"GLProfileViewController","title":"我","imageName":"profile"]
        ]
        var arrayM = [UIViewController]()
        
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    
    /// 使用一个字典创建一个控制器
    /// - Parameter dict: 信息字典[clsName,title,imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String:String]) -> UIViewController {
        ///一个guard守护多个let,后续的let可以使用前面let的值(cls)，多个let用逗号隔开
        guard let clsName = dict["clsName"],
              let title = dict["title"],
              let imageName = dict["imageName"],
              //NSClassFromString返回的是Class?类型。
              //Swift中使用该API还要加上命名空间，否则获取为nil。即namespce.className
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? GLBaseViewController.Type
        else {
            ///如果缺少相关的值，则返回一个默认的空白基类控制器
            return UIViewController()
        }
        
        ///2. 创建子控制器
        let vc = cls.init()
        vc.title = title
        
        ///3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        // 设置tabbarItem.selectedImage时，默认的tintColor会将图片渲染成蓝色。
        // 通过UIImage.withRenderMode(.alwaysOriginal)来获取原始图片 【指定渲染模式】
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        ///4. 设置tabbar的字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
        //设置字号时，必须给.nomarl状态设置，其他状态设置无效。默认字号是12pt.
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = GLNavigationViewController(rootViewController: vc)
        return nav
    }
}
