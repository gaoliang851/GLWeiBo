//
//  ViewController.swift
//  day11-002-emoji字符串的转换
//
//  Created by gaoliang on 2022/1/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //unicode 的 编码，展现使用 UTF8 1~4 个字节表示一个字符
        let code = "0x1f603"
        
        // 实例化字符串扫描
        let scanner = Scanner(string: code)
        
        var result:UInt32 = 0
        
        scanner.scanHexInt32(&result)
        
        
        //let u32Result = result as! UInt32
        
        let c = Character(UnicodeScalar(result)!)
//
        let emoji = String(c)
        
       print(emoji)
    }


}

