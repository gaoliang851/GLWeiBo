//
//  GLVistorView.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/29.
//

import UIKit

/// 访客视图
class GLVistorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置界面
extension GLVistorView {
    private func setupUI() {
        backgroundColor = .white
    }
}
