//
//  GLComposeViewController.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/9.
//

import UIKit

/**
 - 加载视图控制器的时候，如果 XIB 和控制器同名，默认的构造函数会 `优先`加载 XIB
 - 为 ViewController 添加 XIB 步骤
    - 1. 添加一个同名的 Empty XIB
    - 2. XIB 添加一个 View
    - 3. XIB 的 File's owner 选择相应的 ViewController
    - 4. File's owner 的 view 与 添加的 view 做连线

- xib 添加的scrollView, 在没有充满时，默认不可滚动。在xib上勾选 `Bounce Vertically`就可以实现，无论是否填满都可以滚动的效果
 - scrollView 在滚动时隐藏键盘, 在 `keyboard` 中 选择 `Dismiss on drag`
 */

/// 撰写微博控制器
class GLComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        setupUI()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}

private extension GLComposeViewController {
    /// 设置 UI
    func setupUI() {
        setupNavbar()
    }
    
    /// 设置导航栏
    func setupNavbar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(close))
        
        let navColor = UIColor.cz_color(withHex: 0xF7F7F7)
        
        if #available(iOS 15.0, *) {
            let barApp = UINavigationBarAppearance()
            // 背景色
            barApp.backgroundColor = navColor
            barApp.shadowColor = .white
            navigationController?.navigationBar.scrollEdgeAppearance = barApp
            navigationController?.navigationBar.standardAppearance = barApp
        } else {
            // 背景色
            navigationController?.navigationBar.barTintColor = navColor
            
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        // 不透明
        navigationController?.navigationBar.isTranslucent = false
        // navigation控件颜色
        navigationController?.navigationBar.tintColor = .darkGray
    }
}
