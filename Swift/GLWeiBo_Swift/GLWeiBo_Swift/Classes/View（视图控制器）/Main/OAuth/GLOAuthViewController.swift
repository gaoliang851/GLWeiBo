//
//  GLOAuthViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/30.
//

import UIKit
import WebKit

/// 登录界面
class GLOAuthViewController: UIViewController {
    private lazy var webView = WKWebView()
    override func loadView() {
        // 修改根view
        view = webView
        //view.backgroundColor = .white
    
        //设置导航栏的返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",  target: self, action: #selector(close), isBack: true)
        // 设置标题
        title = "登录GL微博"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //拼接授权地址
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(GLAppKey)&redirect_uri=\(GLRedirectURI)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
