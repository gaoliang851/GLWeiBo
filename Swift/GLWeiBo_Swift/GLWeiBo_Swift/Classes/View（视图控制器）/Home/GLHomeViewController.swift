//
//  GLHomeViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

//tableView的cell identifier
fileprivate let cellId = "cellId"

class GLHomeViewController: GLBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 数据源
    lazy var statusList = [String]()
    
    /// 上拉加载标志
    private var isPullup = false
    
    @objc private func showFirends() {
        let vc = GLDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
        print("开始加载....")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.isPullup { //上拉加载
                for i in 0..<15 {
                    self.statusList.append("上拉:\(i)")
                }
            } else { // 下拉刷新
                for i in 0..<15 {
                    self.statusList.insert(i.description, at: 0)
                }
            }
            //将上拉标志设置回去
            self.isPullup = false
            // 结束刷新动画
            self.refreshControl?.endRefreshing()
            // 刷新表格
            self.tableView?.reloadData()
        }
    }
}

// MARK: - 设置界面
extension GLHomeViewController {
    
    override func setupTableView() {
        super.setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navItem.rightBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFirends))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - tableView的数据源
extension GLHomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //2. 设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        //3. 返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statusList.count
    }
    
    /// 无缝上拉加载
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 获取最大的section
        let section = tableView.numberOfSections - 1
        // 2. 获取最大的Row
        let row = tableView.numberOfRows(inSection: section) - 1
        // 3. section匹配，row匹配，则认为是最后一行，开始上拉刷新
        if indexPath.row == row && indexPath.section == section && !isPullup {
            print("上拉加载")
            isPullup = true
            // 开始刷新
            loadData()
        }
    }
}

