//
//  GLWebViewController.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/17.
//

import UIKit
import WebKit

class GLWebViewController: GLBaseViewController {

    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    
    var urlString : String? {
        didSet {
            guard let urlString = urlString ,
                  let url = URL(string: urlString) else {
                return
            }
            webView.load(URLRequest(url: url))
        }
    }
}

extension GLWebViewController {
    override func setupTableView() {
        
        webView.scrollView.contentInset.top = navigationBar.bounds.height
        view.insertSubview(webView, belowSubview: navigationBar)
        
    }
}
