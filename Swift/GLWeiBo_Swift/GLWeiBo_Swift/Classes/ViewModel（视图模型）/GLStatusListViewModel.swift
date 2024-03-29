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


/// 上拉刷新最大尝试次数
fileprivate let maxPullupTryTimes = 3

/// 微博数据列表视图模型
/// 使命：负责微博的数据处理
/// 1. 字典转模型
/// 2. 下拉 / 上拉刷新数据处理
class GLStatusListViewModel  {
    
    /// 微博数组懒加载
    lazy var statusList = [GLStatus]()
    /// 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    /// 加载微博列表
    /// - Parameter isPull    : 是否是上拉加载
    /// - Parameter completion: 完成回调[isSuccess: 网络请求是否成功,shouldRefresh: 是否应该刷新表格]
    func loadStatus(isPull: Bool = false, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool)->()) {
        
        // 判断是否是上拉加载,同时检查刷新错误
        if isPull && pullupErrorTimes > maxPullupTryTimes {
            logi("次数超过限制")
            completion(true,false)
            return
        }
        
        /// 如果是上拉加载，则since_id 为0,since_id 取出数组中第一条微博的 id
        let since_id = isPull ? 0 : statusList.first?.id ?? 0
        /// 如果是下拉竖线，则max_id 为0
        let max_id = !isPull ? 0: statusList.last?.id ?? 0
        
        GLNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: GLStatus.self, json: list ?? []) as? [GLStatus] else {
                // 转换失败, 不刷新表格
                completion(false,false)
                return
            }
            
            print("loadStatus Count: \(array.count)")
            
            // 2. 拼接数据
            if isPull {
                // 下拉刷新,将新的数据放在最前面
                self.statusList += array
            } else {
                // 上拉刷新
                self.statusList = array + self.statusList
            }
            
            // 3. 判断上拉加载的数据量
            if isPull && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess,false)
            } else {
                // 4. 回调
                completion(true,true)
            }
            
        }
    }
}
