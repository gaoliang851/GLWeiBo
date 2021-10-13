//
//  GLNetworkManager+Extension.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/13.
//

import Foundation

// MARK: - 用于封装微博的网络请求
extension GLNetworkManager {
    
    /// 加载微博数据字典数组
    /// - Parameter completion: 完成回调[list: 微博字典数组/是否成功]
    /// - Returns: void
    func statusList(completion: @escaping (_ list :[[String: Any]]?,_ isSuccess :Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenRequest(URLString: urlString, paramters: nil) { (json, isSuccess) in
            
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil
            // 提示：服务器返回的字典数组，就是按照时间的倒序排序的
            let result = (json as? [String:Any])?["statuses"] as? [[String: Any]]
            
            completion(result,isSuccess)
        }
    }
}
