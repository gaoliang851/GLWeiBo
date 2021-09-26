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
    }
    
    @objc private func showFirends() {
        print(#function)
    }
}

extension GLHomeViewController {
    override func setupUI() {
        super.setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFirends))
    }
}
