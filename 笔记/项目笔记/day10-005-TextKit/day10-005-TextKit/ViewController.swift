//
//  ViewController.swift
//  day10-005-TextKit
//
//  Created by gaoliang on 2022/1/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: CZLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label.text = "请点击 https://www.baidu.com"
        
    }

    
}

