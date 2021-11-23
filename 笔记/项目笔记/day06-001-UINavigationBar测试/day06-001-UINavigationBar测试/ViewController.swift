//
//  ViewController.swift
//  day06-001-UINavigationBar测试
//
//  Created by gaoliang on 2021/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nav = TestBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 72))
        
        let navItem = UINavigationItem(title: "test")
        

        nav.items = [navItem]
        nav.setTitleVerticalPositionAdjustment(72-44, for: .default)
        
        view.addSubview(nav)
        
        print(#function)
        
        
    }


}

