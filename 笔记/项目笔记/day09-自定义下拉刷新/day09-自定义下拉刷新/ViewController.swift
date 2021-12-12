//
//  ViewController.swift
//  day09-自定义下拉刷新
//
//  Created by gaoliang on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func test(_ sender: Any) {
        navigationController?.pushViewController(CZTableViewController(), animated: true)
    }
    
}

