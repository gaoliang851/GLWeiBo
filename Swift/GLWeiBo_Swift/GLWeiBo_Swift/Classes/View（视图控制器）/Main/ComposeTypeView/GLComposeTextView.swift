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
    @objc private func textViewChanged() {
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
            selector: #selector(textViewChanged),
            name: UITextView.textDidChangeNotification,
            object: self)
    }
}

// MARK: - 表情键盘专属方法
extension GLComposeTextView {
    /// 向文本中插入表情 [图文混排]
    /// - Parameter em: 选入的表情, nil 表示 删除
    func insertEmoticon(em: CZEmoticon?) {
        
        // 1. em == nil , 则说明是删除按钮
        guard let em = em else {
            // 删除文本，有选中的文本删除选中的，没有选中的，删除光标前的一个文本
            deleteBackward()
            return
        }
        
        // 2. 如果是emoji, 直接插入
        if let emoji = em.emoji,
            let textRange = selectedTextRange {
            replace(textRange, withText: emoji)
        }
        
        // 3. 处理图片表情
        let imageText = em.imageText(font: font!)
        // 3.1 获取当前 textView 属性文本 => 可变的
        // 所有的排版系统中，几乎都有一个共同的特点，插入的字符的显示，跟随前一个字符的属性。
        // 但是本身没有属性
        let attrM = NSMutableAttributedString(attributedString: attributedText)
        
        // 将图像的属性文本插入到当前的光标位置
        attrM.replaceCharacters(in: selectedRange, with: imageText)
        
        // 记录光标位置
        let range = selectedRange
        // 设置文本
        attributedText = attrM
        // 恢复光标位置
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        // 触发代理的文本变化代理方法
        delegate?.textViewDidChange?(self)
        
        // 调用文本变化通知回调方法
        textViewChanged()
    }
    
    /// 返回 textView 对应的纯文本的字符串 [将属性文本转换成文字]
    var emticonText: String {
        // 1. 获取textView 的属性文本
        guard let attrStr = attributedText else {
            return ""
        }
        
        // 2. 需要获得属性文本中的图片 [附件 NSAttachment]
        /// in range: 遍历的范围
        /// 选项 []
        /// 闭包
        var result = ""
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: []) { dict, range, _ in
            if let attachment = dict[NSAttributedString.Key.attachment] as? CZEmoticonAttachment {
                result += attachment.chs ?? ""
            } else {
                /// 纯文本,拼接文本
                let subStr = attrStr.attributedSubstring(from: range).string
                result += subStr
            }
        }
        return result
    }
}
