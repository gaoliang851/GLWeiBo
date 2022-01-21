//
//  CZEmticonCell.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/21.
//

import UIKit


/// 一个cell 就是一个完整的表情布局
class CZEmticonCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        setupUI()
    }
}


private extension CZEmticonCell {
    // - 从 XIB 加载，bounds 是 XIB 中定义的大小，不是size 的大小
    // - 使用纯代码，bounds 则是布局中设置的size 大小
    func setupUI() {
        let rowCount = 3
        let colCount = 7
        
        for i in 0..<21 {
            let row = i / colCount
            let col = i % rowCount
            
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.red
            contentView.addSubview(btn)
        }
    }
}
