//
//  GLRefreshControl.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/12/10.
//

import UIKit
/// 刷新状态切换的临界点
private let GLRefreshOffset: CGFloat = 126

/// 刷新状态
///
/// - Normal:       普通状态，什么都不做
/// - Pulling:      超过连接点，如果放手，开始刷新
/// - WillRefresh:  用户超过临界点,并且放手
enum GLRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}

class GLRefreshControl: UIControl {
    
    // MARK: - 属性
    private weak var scrollView: UIScrollView?
    
    private lazy var refreshView = GLRefreshView.refreshView()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    /// willMove addSubview 方法会调用
    /**
     - 当添加到父视图的时候，newSuperview 是父视图
     - 当父视图被移除，newSuperview 是 nil
     */
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
    
    /// 本视图从父视图上移除
    /// 提示：所有的下拉刷新框架都是监听父视图的 contentOffset
    /// 所有的框架的 KVO 监听实现思路都是这个
    override func removeFromSuperview() {
        // superview 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        
        // superview 不存在了
    }
    
    // 所有 KVO 方法会统一调用此方法
    // 在程序中，通常只监听一个对象的某几个属性，如果属性太多，方法会很乱！
    // 观察者模式，在不需要的时候，都需要释放
    // - 通知中心：如果不释放，什么也不会发生，但会有内存泄露，会有多次注册的可能！
    // - KVO：如果不释放，会崩溃！
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            return
        }
        
        /// 修改刷新控件的大小
        let height = -(sv.contentOffset.y + sv.contentInset.top)
        
        if height < 0 {
            return
        }
        
        // 用户是否正在滚动
        if sv.isDragging {
            /// 高度已经超过阈值，并且之前的状态是正常状态
            if height > GLRefreshOffset && refreshView.refreshState == .Normal {
                print("放手刷新...")
                refreshView.refreshState = .Pulling
                
            }
            /// 用户又把控件拖回去了
            else if height <= GLRefreshOffset && refreshView.refreshState == .Pulling {
                print("继续使劲...")
                refreshView.refreshState = .Normal
            }
            
        } else { //用户放手了
            if refreshView.refreshState == .Pulling {
                print("准备开始刷新...")
                
                beginRefreshing()
            }
        }
        
        frame = CGRect(x: 0, y: 0, width: sv.bounds.width, height: -height)

        print("height=\(height)")
    }
    
    func beginRefreshing() {
        // 判断父视图
        guard let sv = scrollView else { return }
        
        // 判断是否正在刷新,如果正在刷新，直接返回
        if refreshView.refreshState == .WillRefresh {
            return
        }
        
        // 设置刷新视图状态
        refreshView.refreshState = .WillRefresh
        
        // 调整表格间距
        var inset = sv.contentInset
        inset.top += GLRefreshOffset
        sv.contentInset = inset

    }
    
    func endRefreshing() {}
}

extension GLRefreshControl {
    private func setupUI() {
        backgroundColor = super.backgroundColor
        
        // 设置超出边界 不显示
        // clipsToBounds = true
        
        // 添加刷新视图 - 从xib 加载出来，默认是xib中指定的宽高
        addSubview(refreshView)
        
        
        // 为refreshView 添加自动布局，设置 xib 控件的自动布局，需要指定宽高约束
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
    }
}
