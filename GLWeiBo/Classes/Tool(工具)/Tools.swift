//
//  Tools.swift
//  GLWeiBo
//
//  Created by mac on 2020/12/15.
//

import Foundation

func GLLog<T>(_ msg: T,
              file: NSString = #file,
              line: Int = #line,
              fn: String = #function) {
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix,msg)
}

func GLLogTag(file: NSString = #file,
              line: Int = #line,
              fn: String = #function) {
    let msg = "\(file.lastPathComponent)_\(line)_\(fn)"
    print(msg)
}


