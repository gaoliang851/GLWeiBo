//
//  Bundle+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/9/26.
//

import Foundation

extension Bundle {
    var namespace : String {
        infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var appVersion : String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
