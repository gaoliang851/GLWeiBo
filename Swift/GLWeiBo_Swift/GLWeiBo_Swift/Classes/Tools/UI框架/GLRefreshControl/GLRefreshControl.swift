//
//  GLRefreshControl.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/12/10.
//

import UIKit

class GLRefreshControl: UIControl {
    
    // MARK: - 属性
    private weak var scrollView: UIScrollView?
    
    func beginRefreshing() {}
    
    func endRefreshing() {}
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 判断父视图类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        
        scrollView = sv
        
        // KVO 监听父视图的 contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            return
        }
        
        print("scrollview: \(sv.contentOffset), \(sv.contentOffset.y),--\(sv.contentInset.top)")
        
        let height = -(sv.contentOffset.y + sv.contentInset.top)

        print("height is \(height)")
        
        frame = CGRect(x: 0, y: 0, width: sv.bounds.width, height: -height)
        
        
        print("sv bounds is \(sv.bounds)")

    }
    
}

extension GLRefreshControl {
    private func setupUI() {
        backgroundColor = .red
    }
}
