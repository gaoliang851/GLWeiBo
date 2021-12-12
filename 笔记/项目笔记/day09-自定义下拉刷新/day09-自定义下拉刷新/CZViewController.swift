//
//  CZViewController.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2021/12/12.
//

import UIKit

class CZViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom)
        button.setTitle("测试", for: [])
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .orange
        
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
    }
    
    
    @objc func test(_ sender: Any) {
        navigationController?.pushViewController(CZTableViewController(), animated: true)
    }

}
