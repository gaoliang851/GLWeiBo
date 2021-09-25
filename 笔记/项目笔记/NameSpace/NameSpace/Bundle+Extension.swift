//
//  Bundle+Extension.swift
//  NameSpace
//
//  Created by mac on 2021/9/25.
//

import Foundation

extension Bundle {
    var namespace: String {
        infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
