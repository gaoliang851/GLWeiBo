//
//  Log4Swift.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/18.
//

import Foundation

fileprivate var loggerEnable = true

public func setLoggerEnable(enable: Bool) {
    loggerEnable = enable
}

fileprivate func log(tag :String, object: Any?) {
    print("\(tag) : \((object ?? "nil"))")
}

public func logi(_ object: Any?) {
    guard loggerEnable else {
        return
    }
    log(tag: "[info]", object: object)
}

public func loge(_ object: Any?) {
    guard loggerEnable else {
        return
    }
    log(tag: "[error:]", object: object)
}

