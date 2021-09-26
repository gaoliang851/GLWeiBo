//
//  GLBaseViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension GLBaseViewController {
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
    }
}
