//
//  GLDemoViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLDemoViewController: GLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    @objc private func showNext() {
        let vc = GLDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GLDemoViewController {
    
    override func setupTableView() {
        super.setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
        title = "第 \(navigationController?.children.count ?? 0 ) 个"
    }
}


