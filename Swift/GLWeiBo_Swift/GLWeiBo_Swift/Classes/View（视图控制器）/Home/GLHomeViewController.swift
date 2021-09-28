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
        for i in 0...9 {
            statusList.insert(i.description, at: 0)
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

