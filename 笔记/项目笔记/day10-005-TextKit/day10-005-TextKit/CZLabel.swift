//
//  CZLabel.swift
//  day10-005-TextKit
//
//  Created by gaoliang on 2022/1/14.
//

import UIKit

class CZLabel: UILabel {

    // TextKit的3个核心对象
    /// 负责存储内容，是NSMutableAttributedString的子类
    /// 管理一组 NSLayoutManager 对象
    private lazy var textStorage = NSTextStorage()
    
    /// 布局管理器，负责协调布局
    /// 显示 NSTextStorage 对象中保存的字符
    private lazy var textlayoutManager = NSLayoutManager()
    
    /// 文本容器，定义一个排除路径
    /// 也可以定义一个排除路径
    private lazy var textContainer = NSTextContainer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextSystem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareTextSystem()
    }
    
    /// 绘图函数，将文本绘制在Label上
    /// - 在 iOS 中绘制工作是类似于 `油画`似的
    /// - 后绘制的内容会把之前绘制的内容覆盖！
    /// - 尽量避免使用带透明度的颜色，会严重影响性能
    override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        
        /// 绘制背景，如果在文字之后绘制，会覆盖掉绘制的文字
        textlayoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
        /// 绘制 Glyphs 字形
        textlayoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())
    }
}

private extension CZLabel {
    /// 准备文本系统
    func prepareTextSystem() {
        
        prepareTextStorage()
        
        // 2. 添加对象关系
        textStorage.addLayoutManager(textlayoutManager)
        textlayoutManager.addTextContainer(textContainer)
    }
    
    /// 准备文本内容
    func prepareTextStorage() {
        if attributedText != nil {
            textStorage.setAttributedString(attributedText!)
        } else if text != nil {
            textStorage.setAttributedString(NSAttributedString(string: text!))
        } else {
            textStorage.setAttributedString(NSAttributedString(string: ""))
        }
        
        /// 设置 URL 显示的样式
        for r in urlRanges ?? [] {
            textStorage.addAttributes([.foregroundColor:UIColor.red,
                                       .backgroundColor:UIColor.black], range: r)
        }
    }
}


// MARK:  - 正则表达式函数
private extension CZLabel {
    
    /// 返回 textStorage 中的 URL 的 range
    var urlRanges: [NSRange]? {
        
        // 1. 正则表达式
        let pattern = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        
        // 2.多重匹配
        let matchs = regx.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        
        // 3. 遍历数组
        var ranges = [NSRange]()
        
        for m in matchs {
            ranges.append(m.range(at: 0))
        }
        
        return ranges
    }
}
