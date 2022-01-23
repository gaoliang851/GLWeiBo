//
//  CZEmticonCell.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/21.
//

import UIKit


/// 一个cell 就是一个完整的表情布局
class CZEmticonCell: UICollectionViewCell {
    
    //@IBOutlet weak var label: UILabel!
    
    var emoticons: [CZEmoticon]? {
        didSet {
            //print("表情包的数量 \(emoticons?.count)")
            
            //1. 隐藏内部所有按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            // 1.1 删除按钮不隐藏
            contentView.subviews.last?.isHidden = false
            
            // 2. 遍历表情，设置按钮图像
            for (i,em) in (emoticons ?? []).enumerated() {
                let button = contentView.subviews[i] as! UIButton
                // 设置图像 - 如果图像为 nil 会清空图像，避免复用
                button.setImage(em.image, for: .normal)
                // 设置 emoji 字符串 - 如果 emoji 为 nil 会清空 title，避免复用
                button.setTitle(em.emoji, for: .normal)
                
                button.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - 表情按钮点击事件
    
    /// 表情按钮点击事件
    /// - Parameter button: 选中的表情按钮
    @objc private func emticonSelected(button: UIButton) {
        // 1. 取tag，0~20，20对应的是删除按钮
        let tag = button.tag
        
        // 2. 根据 tag 判断是否是删除按钮，如果不是删除按钮，取得表情
        var emoticon: CZEmoticon?
        if tag < emoticons?.count ?? 0 {
            emoticon = emoticons?[tag]
        }
        
        // 3. em 要么是选中的按钮， 如果为nil 对应的是删除按钮
        print(emoticon)
    }
}


private extension CZEmticonCell {
    // - 从 XIB 加载，bounds 是 XIB 中定义的大小，不是size 的大小
    // - 使用纯代码，bounds 则是布局中设置的size 大小
    func setupUI() {
        let rowCount = 3
        let colCount = 7
        
        // 左右间距
        let leftMargin: CGFloat = 8
        // 底部间距, 为分页控件预留控件
        let bottomMargin: CGFloat = 16
        
        let w = (bounds.width - 2 * leftMargin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        for i in 0..<21 {
            // 行数
            let row = i / colCount
            // 列数
            let col = i % colCount
            
            let btn = UIButton(type: .custom)
            let x = leftMargin + CGFloat(col) * w
            let y = h * CGFloat(row)
            let rect = CGRect(x: x, y: y, width: w, height: h)
            btn.frame = rect
            
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
            contentView.addSubview(btn)
            
            // 设置tag, i就是表情的索引
            btn.tag = i
            btn.addTarget(self, action: #selector(emticonSelected), for: .touchUpInside)
        }
        
        // 取出最后一个按钮，设置删除按钮
        let removeButton = contentView.subviews.last as! UIButton
        let image = UIImage(named: "compose_emotion_delete", in: CZEmoticonManager.shared.bundle, compatibleWith: nil)
        let imageHL = UIImage(named: "compose_emotion_delete_highlighted", in: CZEmoticonManager.shared.bundle, compatibleWith: nil)
        removeButton.setImage(image, for: .normal)
        removeButton.setImage(imageHL, for: .selected)
        removeButton.setImage(imageHL, for: .highlighted)
    }
}
