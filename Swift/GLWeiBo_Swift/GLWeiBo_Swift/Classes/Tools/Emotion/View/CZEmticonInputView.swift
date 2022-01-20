//
//  CZEmticonInputView.swift
//  day11-001-表情键盘
//
//  Created by gaoliang on 2022/1/20.
//

import UIKit

class CZEmticonInputView: UIView {
    
    class func inputView() -> CZEmticonInputView {
        let nib = UINib(nibName: "CZEmticonInputView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! CZEmticonInputView
        return v
    }
}
