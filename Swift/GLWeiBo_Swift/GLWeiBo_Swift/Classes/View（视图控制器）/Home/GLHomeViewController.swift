//
//  GLHomeViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLHomeViewController: GLBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func showFirends() {
        print(#function)
        let vc = GLDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GLHomeViewController {
    private func setupUI() {
        navItem.rightBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFirends))
    }
}
