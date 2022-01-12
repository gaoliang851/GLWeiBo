//
//  ViewController.swift
//  010-表情包数据
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: UILabel!
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
        
        demoLabel.attributedText = CZEmoticonManager.shared.findEmoticon(string: "[爱你]")?.imageText(font: demoLabel.font)
        
        //let string = "<a href="">"
        
        // <a href="https://www.baidu.com" ret="windows">haha</a>
        // <a href="(.*?)".*?>(.*?)</a>
        
        let string = "我[爱你]啊[笑哈哈]"
        
        demoLabel.attributedText = emoticonString(string: string)
    }
    
    func emoticonString(string: String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: string)
        
        //1. 建立正则表达式、过滤所有表情文字
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        
        // 2. 匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        
        /// 这里要进行倒序遍历，否则因为替换了前边的表情，导致后边的索引发生改变
        for m in matches.reversed() {
            let r = m.range(at: 0)
            let subStr = (string as NSString).substring(with: r)
            
            if let em = CZEmoticonManager.shared.findEmoticon(string: subStr) {
                attrString.replaceCharacters(in: r, with: em.imageText(font: demoLabel.font))
            }
        }
        
        return attrString
    }

}

