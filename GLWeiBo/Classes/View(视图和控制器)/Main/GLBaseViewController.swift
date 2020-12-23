//
//  GLBaseViewController.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/13.
//

import UIKit

class GLBaseViewController: UIViewController {
    
    /// 自定义导航栏
    lazy var navigationbar = GLNavgationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var title: String? {
        didSet {
            navigationbar.title = title
        }
    }
    
    @objc func nextController() {
        navigationController?.pushViewController(GLBaseViewController(), animated: true)
    }
}

extension GLBaseViewController {
    func setupUI() {
        self.view.backgroundColor = UIColor.cz_random()
        view.addSubview(navigationbar)
        navigationbar.frame = CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: UINavigationBar.getStandNavigationbarHeight())
        navigationbar.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(nextController), isBack: false)
    }
}
