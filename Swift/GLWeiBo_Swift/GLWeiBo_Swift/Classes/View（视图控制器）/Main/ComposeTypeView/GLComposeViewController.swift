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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    //    lazy var sendButton: UIButton = {
//        let btn = UIButton(type: .custom)
//
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        btn.setTitle("发布", for: .normal)
//
//        btn.setTitleColor(.white, for: .normal)
//        btn.setTitleColor(.gray, for: .disabled)
//
//        btn.setBackgroundImage(UIImage(named: "common_button_orange"), for: .normal)
//        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
//        btn.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
//
//        btn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
//
//        return btn
//    }()
    
    
    // MARK: - 视图声明周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: 发布微博
    @IBAction func postStatus() {
        print("发布微博")
    }
}

private extension GLComposeViewController {
    /// 设置 UI
    func setupUI() {
        view.backgroundColor = .white
        setupNavbar()
    }
    
    /// 设置导航栏
    func setupNavbar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",target: self, action: #selector(close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        navigationItem.titleView = titleLabel
        
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
