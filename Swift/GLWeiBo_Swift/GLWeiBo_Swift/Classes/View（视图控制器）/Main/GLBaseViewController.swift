//
//  GLBaseViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import UIKit

class GLBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var navigationBar = GLNavigationBar(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: UINavigationBar.systemNavigationBarHeight))
    
    lazy var navItem: UINavigationItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

extension GLBaseViewController {
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        navigationBar.items = [navItem]
        view.addSubview(navigationBar)
    }
}
