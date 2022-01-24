//
//  ViewController.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    lazy var emticonInputView = CZEmticonInputView.inputView { [weak self] (emticon) in
        self?.insertEmoticon(em: emticon)
    }
    
    
    /// 向文本中插入表情 [图文混排]
    /// - Parameter em: 选入的表情, nil 表示 删除
    private func insertEmoticon(em: CZEmoticon?) {
        
        // 1. em == nil , 则说明是删除按钮
        guard let em = em else {
            // 删除文本，有选中的文本删除选中的，没有选中的，删除光标前的一个文本
            textView.deleteBackward()
            return
        }
        
        // 2. 如果是emoji, 直接插入
        if let emoji = em.emoji,
            let textRange = textView.selectedTextRange {
            textView.replace(textRange, withText: emoji)
        }
        
        // 3. 处理图片表情
        let imageText = em.imageText(font: UIFont.systemFont(ofSize: 18))
        // 3.1 获取当前 textView 属性文本 => 可变的
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 将图像的属性文本插入到当前的光标位置
        attributedText.replaceCharacters(in: textView.selectedRange, with: imageText)
        
        // 记录光标位置
        let range = textView.selectedRange
        // 设置文本
        textView.attributedText = attributedText
        // 恢复光标位置
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //emticonInputView.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        
        textView.inputView = emticonInputView
        
        textView .reloadInputViews()
        
    }
}

