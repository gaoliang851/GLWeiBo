//
//  GLComposeViewController.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/9.
//

import UIKit
import SVProgressHUD

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
    /// 文本编辑视图
    @IBOutlet weak var textView: UITextView!
    /// 底部工具栏
    @IBOutlet weak var toolbar: UIToolbar!
    /// 发布按钮
    @IBOutlet var sendButton: UIButton!
    /// 标题标签 - 换行的热键 option + 回车
    /// 逐行选中文本并且设置属性
    /// 如果想要调整行间距，可以增加一个空行，设置空行字体，lineHeight
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //激活键盘
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 关闭键盘
        textView.resignFirstResponder()
    }
    
    
    @objc private func close() {
        dismiss(animated: true) {
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: 发布微博
    @IBAction func postStatus() {
        
        guard let text = textView.text else {
            return
        }
        
        GLNetworkManager.shared.postStatus(text: text) { result, isSuccess in
            // 修改指示器样式
            SVProgressHUD.setDefaultStyle(.dark)
            
            let message = isSuccess ? "发布成功" : "网络不给力"
            
            SVProgressHUD.showInfo(withStatus: message)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // 恢复样式
                SVProgressHUD.setDefaultStyle(.light)
                self.close()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension GLComposeViewController {
    /// 设置 UI
    func setupUI() {
        view.backgroundColor = .white
        setupNavbar()
        setupToolbar()
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
    }
    
    
    
    // MARK: - 键盘改变通知
    @objc func keyboardChanged(n: Notification) {
        
        /// 获取键盘最终的frame
        guard let rect = (n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
        // 获取键盘弹起动画时长
        let duration = (n.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        else {
            return
        }
        
        //toolbarBottomCons.constant = -(UIScreen.main.bounds.height - rect.origin.y)
        
        toolbarBottomCons.constant = -(navigationController!.view.bounds.height - rect.origin.y)
        
        print("constant: \(toolbarBottomCons.constant)")
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// 设置导航栏
    func setupNavbar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",target: self, action: #selector(close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        navigationItem.titleView = titleLabel
        
        sendButton.isEnabled = false
        
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
    
    
    /// 设置工具栏
    func setupToolbar() {
        // 添加工具栏按钮
        let itemSettings = [["imageName": "compose_toolbar_picture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background"],
            ["imageName": "compose_add_background"]]
        
        var items = [UIBarButtonItem]()
        
        /// 遍历数组
        for dict in itemSettings {
            
            guard let imageName = dict["imageName"] else {
                continue
            }
            
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let button = UIButton(type: .custom)
            
            button.setImage(image, for: .normal)
            button.setImage(imageHL, for: .highlighted)
            
            button.sizeToFit()
            /// 将按钮添加到数组
            items.append(UIBarButtonItem(customView: button))
            /// 将弹簧添加到数组
            items.append(UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil))
        }
        /// 移除最后一个多出来的弹簧
        items.removeLast()
        toolbar.items = items
    }
}

// MARK: - UITextViewDelegate
// 通过代理来控制发布按钮状态
extension GLComposeViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
    }
}
