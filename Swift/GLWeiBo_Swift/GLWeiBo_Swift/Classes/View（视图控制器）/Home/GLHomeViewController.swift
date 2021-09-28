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
    
    lazy var statusList = [String]()
    
    @objc private func showFirends() {
        print(#function)
        let vc = GLDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            for _ in 0..<15 {
                self.statusList.insert((self.statusList.count + 1).description, at: 0)
            }
            // 结束刷新动画
            self.refreshControl?.endRefreshing()
            // 刷新表格
            self.tableView?.reloadData()
        }
    }
}

// MARK: - 设置界面
extension GLHomeViewController {
    override func setupUI() {
        super.setupUI()
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
}

