//
//  GLComposeTypeView.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2022/1/3.
//

import UIKit

class GLComposeTypeView: UIView {

    class func composeTypeView() -> GLComposeTypeView {
        let nib = UINib(nibName: "GLComposeTypeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! GLComposeTypeView
        
        return v
    }
    
    func show() {
        let vc =  UIApplication.shared.windows.filter { window in
            window.isKeyWindow
         }.first?.rootViewController
        
        self.frame = UIScreen.main.bounds
        
        vc?.view.addSubview(self)
    }

}
