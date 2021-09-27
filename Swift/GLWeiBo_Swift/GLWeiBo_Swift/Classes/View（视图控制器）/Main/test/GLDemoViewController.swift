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
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension GLDemoViewController {
    override func setupUI() {
        super.setupUI()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "上一个", target: self, action: #selector(back))
        
        //navigationBar.setColor(UIColor.cz_random())
    }
}


