//
//  GLComposeTextView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/18.
//

import UIKit

class GLComposeTextView: UITextView {

    private lazy var placeholderLabel = UILabel()
    
    override func awakeFromNib() {
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 监听textView变化
    @objc private func textViewChanged(n: Notification) {
        placeholderLabel.isHidden = hasText
    }

}

private extension GLComposeTextView {
    func setupUI() {
        placeholderLabel.font = font
        placeholderLabel.textColor = .lightGray
        
        placeholderLabel.text = "分享新鲜事..."
        
        placeholderLabel.sizeToFit()
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        addSubview(placeholderLabel)
        
        /// 通过通知监听文本变化
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textViewChanged(n:)),
            name: UITextView.textDidChangeNotification,
            object: self)
    }
}
