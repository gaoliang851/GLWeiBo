//
//  GLUserAccount.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/18.
//

import UIKit

fileprivate let fileName :NSString = "user_account.json"

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
    
    override init() {
        super.init()
        //从磁盘读取账户数据
        guard let path = fileName.cz_appendDocumentDir(),
              // 将磁盘数据二进制读取
              let data = NSData(contentsOfFile: path),
              // 将二进制转为字典
              let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:Any] ?? [:] else {
                  return
        }
        // 设置模型
        yy_modelSet(with: dict)
        logi("account info : \(self)")
            
        // expiresDate = Date(timeIntervalSince1970: 300)
        
        // 判断是否过期
        if expiresDate?.isLaterThan(Date()) == false {
            logi("access_token 过期")
            // 清空 access_token
            access_token = nil
            // 清空 uid
            uid = nil
            // 删除磁盘上的用户文件
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    
    /// 保存账号数据
    func saveAccount() {
        // 将模型转为字典
        var dict = self.yy_modelToJSONObject() as? [String:Any] ?? [:]
        // 将字典中的expiress_in移除
        dict.removeValue(forKey: "expires_in")
        // 字典转data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
        let filePath = fileName.cz_appendDocumentDir() else {
            return
        }
        // 写入沙盒
        let result = (data as NSData).write(toFile: filePath, atomically: true)
        logi("filePath is \(filePath),result = \(result)")
    }
    
    override var description: String {
        yy_modelDescription()
    }
}
