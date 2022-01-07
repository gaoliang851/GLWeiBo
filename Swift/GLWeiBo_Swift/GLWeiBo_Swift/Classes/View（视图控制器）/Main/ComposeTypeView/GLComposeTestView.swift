//
//  GLComposeTestView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/7.
//

import UIKit

class GLComposeTestView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        print("---???")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("==???\(event)")
    }
}
