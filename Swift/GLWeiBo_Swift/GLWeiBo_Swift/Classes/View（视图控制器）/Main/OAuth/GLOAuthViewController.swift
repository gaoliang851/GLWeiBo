//
//  GLOAuthViewController.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/30.
//

import UIKit
import WebKit
import SVProgressHUD

/// 登录界面
class GLOAuthViewController: UIViewController {
    private lazy var webView = WKWebView()
    override func loadView() {
        // 修改根view
        view = webView
        webView.navigationDelegate = self
        // 取消滚动
        webView.scrollView.isScrollEnabled = false
        //view.backgroundColor = .white
    
        //设置导航栏的返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",  target: self, action: #selector(close), isBack: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
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
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    /**
     自动填充
     */
    @objc private func autoFill() {
        let userName = "15010253680"
        let passwd = "GAOliang851*"
        let autoFillJavaScript = "document.getElementById(\"loginName\").value=\"\(userName)\";"
        + "document.getElementById(\"loginPassword\").value=\"\(passwd)\""
        webView.evaluateJavaScript(autoFillJavaScript,completionHandler: nil)
    }
}

extension GLOAuthViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        logi("加载URL：" + (navigationAction.request.url?.absoluteString ?? "default"))
        
        //如果没有跳转到指定地址就直接返回
        if navigationAction.request.url?.absoluteString.hasPrefix(GLRedirectURI) == false {
            decisionHandler(.allow)
            return
        }
        
        //跳转到回调地址，但是没有code参数，则认为取消了授权
        if navigationAction.request.url?.query?.hasPrefix("code=") == false {
            logi("用户取消了授权")
        } else {
            
            /**
             Swift3废除了subString(from\to\with:)字符串截取方法。
             而截取方法改成了：
             let newStr = String(str[..<index]) // = str.substring(to: index) In Swift 3
             let newStr = String(str[index...]) // = str.substring(from: index) In Swif 3
             let newStr = String(str[range]) // = str.substring(with: range) In Swift 3
             */
            //获取code
            let code = String(navigationAction.request.url?.query?["code=".endIndex...] ?? "")
            logi("获取code：\(code)")
            GLNetworkManager.shared.loadToken(code: code) { (isSuccess) in
                if isSuccess {
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: GLUserLoginSuccessNotification),
                        object: nil)
                    self.close()
                } else {
                    SVProgressHUD.showInfo(withStatus: "登录失败")
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
}
