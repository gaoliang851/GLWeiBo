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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

extension GLBaseViewController {
    
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        setupNavigationBar()
        setupTableView()
    }
    
    /// 设置导航条的方法
    fileprivate func setupNavigationBar() {
        navigationBar.items = [navItem]
        //设置navigationbar标题颜色
        navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        view.addSubview(navigationBar)
    }
    /// 设置table View
    fileprivate func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
    }
}
