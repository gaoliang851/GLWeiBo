//
//  GLHomeViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

fileprivate let cellId = "GLHomeViewControllerCellId"

class GLHomeViewController: GLBaseViewController {
    
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    @objc func showFriends() {
        GLLogTag()
    }
    
    /// 实现默认的数据加载方式
    override func loadData() {
        refreshControl?.beginRefreshing()
        ///模拟从服务端加载数据
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for i in 0..<25 {
                if self.isPullup {
                    self.dataSource.append("上拉\(i)")
                } else {
                    self.dataSource.insert("or + \(i)", at: i)
                }
                self.isPullup = false
                self.refreshControl?.endRefreshing()
            }
            self.tableView?.reloadData()
        }
    }
    
    

}

//MARK: 设置界面
extension GLHomeViewController {
    
    /// 设置界面
    private func setupUI() {
        setupNavgationbar()
        setupTableView()
    }
    
    private func setupNavgationbar () {
        navigationbar.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends), isBack: false)
    }
    
    /// 设置表格
    private func setupTableView() {
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

//MARK: 数据源实现
extension GLHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}
