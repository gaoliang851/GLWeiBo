//
//  String+Extension.swift
//  正则表达式的基本使用
//
//  Created by gaoliang on 2022/1/10.
//

import Foundation

extension String {
    
    func cz_href() -> (link: String, text: String)? {
        
        // 创建匹配表达式
        let pattern = "<a href=\"(.*?)\".*?\">(.*?)</a>"
        
        // 创建正则表达式
       guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
             let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0,
                                                                                length: count))
        else {
           return nil
        }
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        //print("\(link) -- \(text)")
        return (link,text)
    }
    
}
