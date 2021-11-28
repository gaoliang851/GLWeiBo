//
//  GLHomeViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit
import AFNetworking

//tableView的cell identifier
fileprivate let cellId = "cellId"

class GLHomeViewController: GLBaseViewController {
    
    private lazy var listViewModel = GLStatusListViewModel()
    
    /// 上拉加载标志
    private var isPullup = false
    
    @objc private func showFirends() {
        let vc = GLDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func clickTitleBtn(button: UIButton) {
        logi(#function)
        button.isSelected = !button.isSelected
    }
    
    override func loadData() {
        logi("开始加载....")
        refreshControl?.beginRefreshing()
        listViewModel.loadStatus(isPull: self.isPullup) { (isSuccess,shouldRefresh) in
            //将上拉标志设置回去
            self.isPullup = false
            // 结束刷新动画
            self.refreshControl?.endRefreshing()
            // 刷新表格
            if shouldRefresh {
                self.tableView?.reloadData()
            }
        }
    }
}

// MARK: - 设置界面
extension GLHomeViewController {
    
    override func setupTableView() {
        super.setupTableView()
        tableView?.register(UINib(nibName: "GLStatusNormalCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        // 设置自动行高
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 300
        
        // 取消cell下面的黑线
        tableView?.separatorStyle = .none
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        logi(#function)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFirends))
        
        let title = GLNetworkManager.shared.userAccount.screen_name
        let titleBtn = GLTitleButton(title: title)
        
        titleBtn.addTarget(self, action: #selector(clickTitleBtn), for: .touchUpInside)
        
        navItem.titleView = titleBtn
    }
}

// MARK: - tableView的数据源
extension GLHomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GLStatusCell
        //2. 设置cell
        // 设置微博内容
        cell.stausLabel?.text = listViewModel.statusList[indexPath.row].status.text
        //3. 返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.statusList.count
    }
    
    /// 无缝上拉加载
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 获取最大的section
        let section = tableView.numberOfSections - 1
        // 2. 获取最大的Row
        let row = tableView.numberOfRows(inSection: section) - 1
        // 3. section匹配，row匹配，则认为是最后一行，开始上拉刷新
        if indexPath.row == row && indexPath.section == section && !isPullup {
            logi("上拉加载")
            isPullup = true
            // 开始刷新
            loadData()
        }
    }
}

