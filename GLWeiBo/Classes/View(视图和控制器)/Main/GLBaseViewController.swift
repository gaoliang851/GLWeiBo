//
//  GLBaseViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

class GLBaseViewController: UIViewController {
    
    /// 自定义导航栏
    lazy var navigationbar = GLNavgationBar()
    
    /// 表格视图
    /// 定义为可选的原因是，并不是肯定会用到表格视图，用不到则创建
    var tableView: UITableView?
    /// 自定义刷新控件
    var refreshControl: UIRefreshControl?
    /// 上拉加载标志位
    var isPullup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var title: String? {
        didSet {
            navigationbar.title = title
        }
    }
    
    /// 需要子类去实现
    /// 如果子类没有实现，则关闭刷新控件
    @objc func loadData() {
        refreshControl?.endRefreshing()
    }
}

//MARK: - 设置界面
extension GLBaseViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor.cz_random()
        setupNavigationBar()
        setupTableView()
    }
    
    /// 设置自定义导航栏
    private func setupNavigationBar() {
        view.addSubview(navigationbar)
        navigationbar.frame = CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: UINavigationBar.getStandNavigationbarHeight())
        
    }
    
    /// 封装表格视图
    private func setupTableView() {
        
        /// iOS11以后，UIScrollView.contentInsetAdjustmentBehavior属性，
        /// 会自动设置tableView的ContentSize来避免默认的Navigationbar和tabbar遮挡，
        /// 但这个属性对于自定义的Navigationbar是无效的，为了解决遮挡问题，有两种解决方式
        
        ///第一种：关闭contentInsetAdjustmentBehavior，frame=view.bounds，手动设置contentInset
        tableView = UITableView(frame: view.bounds,style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationbar)
        if #available(iOS 11, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        }
        tableView?.contentInset = UIEdgeInsets(top: navigationbar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        
        ///第二种：直接设置不被遮挡的frame
        //var tableViewFrame = view.bounds
        //tableViewFrame.origin.y = navigationbar.bounds.height
        //tableViewFrame.size.height =  view.bounds.height - navigationbar.bounds.height - (tabBarController?.tabBar.bounds.height ?? 0)
        //tableView = UITableView(frame: tableViewFrame,style: .plain)
        //view.insertSubview(tableView!, belowSubview: navigationbar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        /// 创建刷新控件
        refreshControl = UIRefreshControl()
        /// 添加到表格视图
        tableView?.addSubview(refreshControl!)
        /// 添加事件
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
/// 这里只提供一个默认的实现，需要子类自己实现这里的方法
extension GLBaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //判断是不是最后一个section
        let section = indexPath.section
        if section != tableView.numberOfSections - 1 {
            return
        }
        let row = indexPath.row
        //判断是不是最后一个row,并且没有在加载中
        if (row == tableView.numberOfRows(inSection: section) - 1) && !isPullup  {
            GLLog("last row")
            isPullup = true
            loadData()
        }
    }
}
