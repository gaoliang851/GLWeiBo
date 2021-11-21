//
//  GLBaseViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var navigationBar = GLNavigationBar(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: UINavigationBar.systemNavigationBarHeight))
    
    lazy var navItem: UINavigationItem = UINavigationItem()
    
    /// 这里定义成可选的，原因是当用户没有登录是，tableView是不需要创建的
    var tableView: UITableView?
    /// 下拉刷新控件
    var refreshControl: UIRefreshControl?
    
    /// 访客视图属性字典
    var vistorInfo: [String: String]?
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // 用户登录才去请求，否则什么都不做
        GLNetworkManager.shared.userLogin ? loadData() : ()
        
        // 注册通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginSuccess),
                                               name: Notification.Name(rawValue: GLUserLoginSuccessNotification),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 网络加载的方法，在viewDidLoad中统一调用
    /// 如果子类不实现该方法，默认是关闭refreshControl的
    @objc func loadData() {
        refreshControl?.endRefreshing()
    }
}

extension GLBaseViewController {
    
    private func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        setupNavigationBar()
        GLNetworkManager.shared.userLogin ? setupTableView() : setupVistorView()
    }
    
    /// 设置导航条的方法
    private func setupNavigationBar() {
        navigationBar.items = [navItem]
        //设置navigationbar标题颜色
        navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        view.addSubview(navigationBar)
    }
    /// 设置table View
    @objc func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        /**
         automaticallyAdjustsScrollViewInsets是UIViewController的一个属性,
         iOS7.0引入，11.0废除
         之后其作用被UIScrollView的新属性contentInsetAdjustmentBehavior所取代,
         如设置为UIScrollViewContentInsetAdjustmentAutomatic等
         作用：默认情况下，它可以保证滚动视图的内容自动偏移，不会被UINavigationBar与UITabBar遮挡。
         */
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            // iOS11及以上的系统该属性失效
            automaticallyAdjustsScrollViewInsets = false
        }
        // 处理表格内容的缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 0,
                                               right: 0)
        // 处理导航条的缩进
        // TODO: FIX ME
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        // 1.> 创建下拉刷新控件,UIRefreshControl的frame是固定
        refreshControl = UIRefreshControl()
        // 2.> 添加到tableview
        tableView?.addSubview(refreshControl!)
        // 3.> 添加点击事件，当UIRefreshControl开始旋转的时候，会触发 UIControl.Event.valueChanged事件
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    /// 设置访客视图
    private func setupVistorView() {
        let vistorView = GLVistorView(frame: view.bounds)
        view.insertSubview(vistorView, belowSubview: navigationBar)
        vistorView.vistorInfo = vistorInfo
        
        /**
         * vistorView公开了loginButton和registerButton,允许外部直接访问。
         * 这样可以在外部为loginButton和registerButton addTargetAction
         * 使用代理传递消息是为了在控制器和视图之间解藕，让视图能够被多个控制器复用
         * 但是，如果视图仅仅只是为了封装代码，而从控制器中剥离出来的，
         * 并且能够确认该视图不会被其他控制器引用，则可以直接通过 addTarget 的方式为该视图中的按钮添加监听方法
         * 这样做的代价是耦合度高，控制器和视图绑定在一起，但是会省略部分冗余代码
         */
        vistorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        vistorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 设置未登录时 全局统一的导航栏样式
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        
        navigationBar.tintColor = .orange
    }
}

/// 这里是为了隔离TableView的数据源方法，子类直接实现即可
extension GLBaseViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

//MARK: - 注册和登录按钮事件
extension GLBaseViewController {
    
    @objc func loginSuccess(n: Notification) {
        logi("登录成功：\(n)")
        // 在访问 view 的 getter 时，如果 view == nil,
        // 则会调用 loadView -> viewDidLoad
        view = nil
        
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        
        // 注销通知 -> 重新执行 viewDidLoad 会被再次注册! 避免通知被多次注册，会造成多次回调
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func login() {
        logi("用户登录")
        
        //发送用户需要登录通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GLUserShouldLoginNotification), object: nil)
    }
    
    @objc func register() {
        logi("用户注册")
    }
    
}
