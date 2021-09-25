//
//  ViewController.swift
//  day01-002-懒加载
//
//  Created by mac on 2021/9/24.
//

import UIKit

class ViewController: UIViewController {
    private lazy var label4 = DemoLabel()
    
    private lazy var label: DemoLabel = {
        var label = DemoLabel()
        label.text = "hello world"
        label.sizeToFit()
        view.addSubview(label)
        return label
    }()
    
    var label2: DemoLabel?
    
    lazy var label3 = { () -> DemoLabel in
        var label = DemoLabel()
        label.text = "hello world"
        label.sizeToFit()
        view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        label.center = view.center
        
        label2 = DemoLabel()
        label2?.text = "Hello world"
        label2?.frame = CGRect(x: 50, y: 50, width: 0, height: 0)
        label2?.sizeToFit()
        self.view.addSubview(label2!)
    }


}

