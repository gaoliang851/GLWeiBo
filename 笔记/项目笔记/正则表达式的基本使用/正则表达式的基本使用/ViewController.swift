//
//  ViewController.swift
//  正则表达式的基本使用
//
//  Created by gaoliang on 2022/1/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "<a href=\"https://www.baidu.com\" rel=\"nofollow\">微博 weibo.com</a>"
        
        let result = string.cz_href()
    
        print("\(result?.link) -- \(result?.text)")
    }
    
    
    func test() {
        //  <a href=\"https://www.baidu.com\" rel=\"nofollow\">微博 weibo.com</a>
        let string = "<a href=\"https://www.baidu.com\" rel=\"nofollow\">微博 weibo.com</a>"
        
        // 1. 创建正则表达式
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
//        let pattern = ">(.*?)</"
        
        //
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return
        }
        
        // 2.进行查找
        // [只找第一个匹配项/查找多个匹配项]
        guard let result = regx.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) else {
            print("没有找到匹配项")
            return
        }
        
        // 3. result 中只有两个重要的方法
        // result.numberOfRanges -> 查找的范围数量
        // result.range(at: idx) -> 指定`索引`位置的的范围
        print("找到的数量 \(result.numberOfRanges)")
        
        for idx in 0..<result.numberOfRanges {
            let r = result.range(at: idx)
            let subStr = (string as NSString).substring(with: r)
            print("\(idx) - \(subStr)")
        }
    }


}

