//
//  ViewController.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let HMEBundlePath = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil)
        
        let HMEBundle = Bundle(path: HMEBundlePath!)
        
//        let imagePath = HMEBundle?.path(forResource: "", ofType: nil)
        
        // let image = UIImage(named: "lxh/lxh_beicui.png", in: HMEBundle, compatibleWith: nil)
        
        print("adb = \(CZEmoticonManager.shared.packages.last?.emoticons.first?.image)")
    }

}

