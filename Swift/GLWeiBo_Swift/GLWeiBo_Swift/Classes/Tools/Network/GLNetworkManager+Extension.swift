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
    /// - Parameters:
    ///   - since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    ///   - max_id: 返回ID小于或等于max_id的微博，默认为0。
    ///   - completion: 完成回调[list: 微博字典数组/是否成功]
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0,completion: @escaping (_ list :[[String: Any]]?,_ isSuccess :Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        // since_id用于获取最新的微博，该参数用来下拉加载最新的微博
        // max_id用于获取之前的微博，该参数用来上拉加载, -1是为了防止每次获取的最后一条微博重复
        let maxId = max_id - 1
        let params = ["since_id":since_id,
                      "max_id":maxId > 0 ? maxId : 0]
        
        tokenRequest(URLString: urlString, paramters: params) { (json, isSuccess) in
            
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil
            // 提示：服务器返回的字典数组，就是按照时间的倒序排序的
            let result = (json as? [String:Any])?["statuses"] as? [[String: Any]]
            
            completion(result,isSuccess)
        }
    }
    
    
    /// 检测未读微博的数量
    func unreadCount(completion: @escaping (_ count: Int)->() ) {
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        guard let user_id = userAccount.uid else {
            return
        }
        
        let params = ["uid":user_id]
        
        tokenRequest(URLString: urlString, paramters: params) { (json, isSuccess) in
            let count = (json as? [String:Any])?["status"] as? Int ?? 0
            completion(count)
        }
    }
}


// MARK: 用于加载用户授权
extension GLNetworkManager {
    
    func loadToken(code : String) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":GLAppKey,
                      "client_secret":GLAppSecret,
                      "grant_type":"authorization_code",
                      "code": code,
                      "redirect_uri":GLRedirectURI]
        
        request(method: .POST,
                URLString:urlString ,
                paramters: params) { json, isSuccess in
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            logi(self.userAccount)
            /// 保存账户
            self.userAccount.saveAccount()
        }
    }
    
}
