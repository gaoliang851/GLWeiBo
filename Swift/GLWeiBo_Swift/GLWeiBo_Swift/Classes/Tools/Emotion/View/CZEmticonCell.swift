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
    /*
    override func awakeFromNib() {
        setupUI()
    }*/
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
        }
    }
}
