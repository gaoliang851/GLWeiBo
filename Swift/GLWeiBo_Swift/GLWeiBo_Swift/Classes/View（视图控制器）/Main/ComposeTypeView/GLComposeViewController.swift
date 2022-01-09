//
//  GLComposeViewController.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/9.
//

import UIKit

class GLComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cz_random()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(close))
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}
