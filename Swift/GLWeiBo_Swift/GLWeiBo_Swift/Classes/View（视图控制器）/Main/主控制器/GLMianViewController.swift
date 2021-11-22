//
//  GLMianViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit
import SVProgressHUD

/// 主控制器
class GLMianViewController: UITabBarController {
    
    /// 定时检查未读的微博
    private var timer: Timer?
    
    /// 撰写添加按钮
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",backgroundImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        // 设置代理
        delegate = self
        
        //接受用户登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(n:)), name: NSNotification.Name(rawValue: GLUserShouldLoginNotification), object: nil)
    }
    
    /// 撰写按钮的点击事件
    /// @objc：允许方法以OC的消息发送机制调用方法
    @objc private func composeStatus() {
        logi("撰写微博")
    }
    
    
    /// 该方法是接收到用户登录的通知后调用的方法
    /// - Parameter n: 通知
    @objc private func userLogin(n: Notification) {
        
        //根据是否展示提示信息来决定是否延迟拉起授权页
        var deadline = DispatchTime.now()
        
        // 如果object不为nil,需要提示用户登录
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "登录信息已过期，请重新登录")
            deadline = .now() + 2
        }
        
        //拉起授权页页面
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let nav = UINavigationController(rootViewController: GLOAuthViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
        
    }
    
    /// 设置支持的方向
    /// portrait  : 竖屏，
    /// landscape : 竖屏，
    /// - 使用代码控制控制设备的方向，好处，可以在需要的横屏的时候，单独处理！
    /// - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向！
    /// - 如果播放视频，通常是通过 modal 展现的!
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    deinit {
        timer?.invalidate()
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITabBarControllerDelegate
extension GLMianViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 获取要展示的Controller的索引
        let index = (children as NSArray).index(of: viewController)
        
        // 如果当前是首页，并且用户点击了两次
        if selectedIndex == 0 && index == selectedIndex {
            logi("点击了首页")
            
            // 获取控制器
            let nav = viewController as! UINavigationController
            let homeVC = nav.children[0] as! GLHomeViewController
            
            // 滚动到顶部
            homeVC.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
            // 刷新数据 - 增加延迟，是保证表格先滚动到顶部在刷新
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                homeVC.loadData()
            }
            
            // 清除tabItem的 badgeNumber
            homeVC.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        // 防止空白的占位ViewController穿帮
        return !viewController.isMember(of: UIViewController.self)
    }
}

// MARK: - 时钟设置
extension GLMianViewController {
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(timerUpdata), userInfo: nil, repeats: true)
    }
    
    @objc private func timerUpdata() {
        
        //用户登录才去请求未读微博，否则不做任何处理
        if !GLNetworkManager.shared.userLogin { return }
        
        GLNetworkManager.shared.unreadCount { (count) in
            logi("检测到 \(count)条 微博未读")
            self.tabBar.items?.first?.badgeValue = count > 0 ? "\(count)" : nil
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

// extension类似于OC中的分类,在 Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个extension中
// 便于维护代码
// 注意：和OC的分类一样，extension中不能定义属性
// MARK: - 设置界面
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
        let jsonPath = NSURL(fileURLWithPath: AppDelegate.configFilePathOnDisk)
        var data = NSData(contentsOf: jsonPath as URL)
        
        if data == nil {
            let bundlePath = Bundle.main.path(forResource: "main", ofType: "json")
            data = NSData(contentsOfFile: bundlePath!)
        }
        
        guard let controlelrsInfoDict = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: Any]] else {
            return
        }
        
        var arrayM = [UIViewController]()
        for dict in controlelrsInfoDict {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    
    /// 根据字典创建一个子控制器
    /// - Parameter dict: 信息字典 [clsName,title,imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String: Any]) -> UIViewController {
        // 1. 获取字典内容，如果没有获取到就返回一个默认的UIViewController
        guard let clsName = dict["clsName"] as? String,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? GLBaseViewController.Type,
              let vistorInfo = dict["vistorInfo"] as? [String: String] else {
            return UIViewController()
        }
        // 2.创建控制器，设置title和image
        let vc = cls.init()
        vc.title = title
        //设置访客视图属性字典
        vc.vistorInfo = vistorInfo
        // 3. 设置图像，并设置以原有模式显示
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        // 4. 设置tabbar的字体
        // 4.1 设置高亮（选中）状态下的字体颜色
        /**
         * 记录适配iOS13发现设置UITabBarItem的颜色，
         * 未选中状态下无效为默认颜色，选中状态下有效，
         * 但是push后再返回，tabBarItem选中颜色变为系统蓝色。适
         * 配方法提供如下
         */
        if #available(iOS 13.0, *) {
            // 选中颜色
            tabBar.tintColor = .orange
            //默认颜色
            tabBar.unselectedItemTintColor = .darkGray
        } else {
            // iOS 13以下
            vc.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.orange], for: .selected)
            vc.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.darkGray], for: .normal)
        }
        
        
        // 4.2 如果要设置字体大小可以选在在Normal Status下,设置如果字体大小，高亮状态下设置无效
        // vc.tabBarItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 25)], for: .normal)
        // 5. 设置NavgationController
        let navgationController = GLNavigationController(rootViewController: vc)
        return navgationController
    }
}
