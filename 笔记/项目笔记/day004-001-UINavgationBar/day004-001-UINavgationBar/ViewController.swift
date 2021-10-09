//
//  ViewController.swift
//  day004-001-UINavgationBar
//
//  Created by mac on 2021/10/9.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "左边", style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "右边", style: .plain, target: self, action: #selector(test))
        
        // 设置navigationbar标题的样式
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.orange,
                                                                        .font:UIFont.systemFont(ofSize: 24)]
        //barTintColor可以设置navigationBar的背景颜色
        navigationController?.navigationBar.barTintColor = .red
        
        //tintColor可以设置navigationBar的UIBarButtonItem的文字颜色
        navigationController?.navigationBar.tintColor = .green
        
        
    }

    @objc func test(sender: UIBarButtonItem) {
        print("test \(sender.title ?? "")")
    }
}

