//
//  GLStatusListViewModel.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/13.
//

import Foundation
import YYModel


/**
 * 父类的选择:
 * - 如果类需要使用 `KVC` 或者字典转模型框架设置对象值，类就要继承自 NSObject
 * - 如果类只是包装一些代码逻辑，可以不用任何父类，好处：更加轻量级
 */

/// 微博数据列表视图模型
/// 使命：负责微博的数据处理
/// 1. 字典转模型
/// 2. 下拉 / 上拉刷新数据处理
class GLStatusListViewModel  {
    
    /// 微博数组懒加载
    lazy var statusList = [GLStatus]()
    
    /// 加载微博列表
    /// - Parameter completion: 完成回调
    func loadStatus(completion: @escaping (_ isSuccess: Bool)->()) {
        
        /// 获取已经获取微博数据中ID最大的那个
        let since_id = statusList.first?.id ?? 0
        
        GLNetworkManager.shared.statusList(since_id: since_id) { (list, isSuccess) in
            
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: GLStatus.self, json: list ?? []) as? [GLStatus] else {
                //
                completion(false)
                return
            }
            
            print("loadStatus Count: \(array.count)")
            
            // 2. 拼接数据
            // 2.1 下拉刷新,将新的数据放在最前面
            self.statusList = array + self.statusList
            
            // 3. 回调
            completion(true)
        }
    }
}
