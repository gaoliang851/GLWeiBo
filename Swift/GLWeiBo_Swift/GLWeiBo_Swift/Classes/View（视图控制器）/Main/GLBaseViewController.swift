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
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    /// 网络加载的方法，在viewDidLoad中统一调用
    func loadData() {
        
    }
}

extension GLBaseViewController {
    
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        setupNavigationBar()
        setupTableView()
    }
    
    /// 设置导航条的方法
    private func setupNavigationBar() {
        navigationBar.items = [navItem]
        //设置navigationbar标题颜色
        navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        view.addSubview(navigationBar)
    }
    /// 设置table View
    private func setupTableView() {
        
        
        
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
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 0,
                                               right: 0)
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
