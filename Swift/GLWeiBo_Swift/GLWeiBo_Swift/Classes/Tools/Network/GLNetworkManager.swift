//
//  GLNetworkManager.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/12.
//

import UIKit
import AFNetworking

enum GLHTTPMethod {
    case GET
    case POST
}

/// 网络工具类
class GLNetworkManager: AFHTTPSessionManager {
    
    /// 网络工具单例
    static let shared = GLNetworkManager()
    
    lazy var userAccount = GLUserAccount()
    
    /// 是否登录的标志
    var userLogin : Bool {
        userAccount.access_token != nil
    }
    
    /// 专门负责拼接 token 的网络请求方法
    /// - Parameters:
    ///   - method: GET \ POST
    ///   - URLString: URLString
    ///   - paramters: 参数字典
    ///   - completion: 完成回调
    /// - Returns: Void
    func tokenRequest(method: GLHTTPMethod = .GET,URLString: String,paramters: [String: Any]?,completion: @escaping (Any?,Bool)->()) {
        // 处理token 字典
        // 0> 判断 token 是否为 nil, 为nil直接返回，程序执行过程中，一般token不会nil
        guard let token = userAccount.access_token else {
            logi("没有token！需要登录")
            
            //处理没有token
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: GLUserShouldLoginNotification),
                object: nil)
            
            completion(nil,false)
            return
        }
        
        // 1> 判断参数字典是否存在，如果为nil, 应该新建一个字典
        var paramters = paramters
        if paramters == nil {
            // 实例化字典
            paramters = [String : Any]()
        }
        
        // 2> 设置参数字典,此处字典一定有值，用!也可以
        paramters?["access_token"] = token
        
        // 3> 调用request 发起真正的网络请求
        request(method: method, URLString: URLString, paramters: paramters, completion: completion)
        
    }
    
    
    /// 封装AFN的 GET / POST 请求
    /// - Parameters:
    ///   - method: 请求方法[GET,POST]
    ///   - URLString: 请求地址
    ///   - paramters: 请求参数
    ///   - completion: 回调
    func request(method: GLHTTPMethod = .GET,URLString: String,paramters: [String: Any]?,completion: @escaping (Any?,Bool)->()) {
        // 成功的回调
        let success = { (task: URLSessionTask,json: Any?)->() in
            completion(json,true)
        }
        //失败的回调
        let failure = { (task: URLSessionDataTask?,error: Error)->() in
            
            //针对 403 处理用户 token 过期
            // 对于测试用户(应用程序还没提交给新浪微博审核)每天的刷新量是有限的!
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                logi("Token 过期了")
                
                // Token过期了,这里object 参数有值，是代表需要提示用户请登录
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: GLUserShouldLoginNotification),
                    object: "bad token")
            }
            
            logi("网络请求错误 \(error)")
            
            completion(nil,false)
        }
        if method == .GET {
            get(URLString, parameters: paramters, headers: nil, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: paramters, headers: nil, progress: nil, success: success, failure: failure)
        }
    }
}
