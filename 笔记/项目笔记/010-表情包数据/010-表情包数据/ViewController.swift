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
        
        var t1 = Date().timeIntervalSince1970
        
        print("adb = \(CZEmoticonManager.shared.findEmoticon(string: "[爱你]"))")
        
        var t2 = Date().timeIntervalSince1970
        
        let c1 = t2 - t1
        
        print("1: \(t2 - t1)")
        
        t1 = Date().timeIntervalSince1970
        
        print("adb = \(CZEmoticonManager.shared.findEmoticon(string: "[爱你]"))")
        
        t2 = Date().timeIntervalSince1970
        
        let c2 = t2 - t1
        
        print("c2 < c1 ? \(c2 < c1)")
    }

}

