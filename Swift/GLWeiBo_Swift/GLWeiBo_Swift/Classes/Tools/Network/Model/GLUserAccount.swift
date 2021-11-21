//
//  GLUserAccount.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/18.
//

import UIKit

@objcMembers
class GLUserAccount: NSObject {
    /// 访问令牌
    var access_token: String?
    /// 用户uid
    var uid: String?
    /// access_token的声明周期,单位是秒
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 过期日期
    var expiresDate: Date?
    
    /// 保存账号数据
    func saveAccount() {
        var dict = self.yy_modelToJSONObject() as? [String:Any] ?? [:]
        dict.removeValue(forKey: "expires_in")
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
        let filePath = ("user_account.json" as NSString).cz_appendDocumentDir() else {
            return
        }
        let result = (data as NSData).write(toFile: filePath, atomically: true)
        logi("filePath is \(filePath),result = \(result)")
    }
    
    override var description: String {
        yy_modelDescription()
    }
}
