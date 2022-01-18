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

}

private extension GLComposeTextView {
    func setupUI() {
        placeholderLabel.font = font
        placeholderLabel.textColor = .lightGray
        
        placeholderLabel.text = "分享新鲜事..."
        
        placeholderLabel.sizeToFit()
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        addSubview(placeholderLabel)
    }
}
