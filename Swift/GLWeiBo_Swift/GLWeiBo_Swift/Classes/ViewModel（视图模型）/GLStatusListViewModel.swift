//
//  GLStatusListViewModel.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/13.
//

import Foundation
import YYModel
import SDWebImage


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
    lazy var statusList = [GLStatusViewModel]()
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
        let since_id = isPull ? 0 : statusList.first?.status.id ?? 0
        /// 如果是下拉竖线，则max_id 为0
        let max_id = !isPull ? 0: statusList.last?.status.id ?? 0
        
        GLNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 0 判断网络请求是否成功
            if !isSuccess {
                completion(false,false)
                return
            }
            
            //1 定义一个可变数组
            var array = [GLStatusViewModel]()
            
            // 2> 遍历服务器返回的字典数组,字典转模型
            for dict in list ?? [] {
                guard let model = GLStatus.yy_model(with: dict) else {
                    continue
                }
                array.append(GLStatusViewModel(model: model))
            }
            
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
                /// 缓存玩单张图片之后，再回调
                self.cacheSignleImage(list: array) {
                    // 4. 回调
                    completion(true,true)
                }
                
            }
            
        }
    }
    
    
    /// 缓存单张图片
    /// - Parameter list: vm list
    private func cacheSignleImage(list: [GLStatusViewModel],execute work: @escaping () -> Void) {
        
        let group = DispatchGroup()
        // 缓存图片总大小
        var length = 0
        
        for vm in list {
            // 如果图片的数量不是一张，就跳过
            if vm.picURLs?.count != 1 {
                continue
            }
            
            guard let picUrlStr = vm.picURLs?.first?.thumbnail_pic,
            let url = URL(string: picUrlStr) else {
                continue
            }
            
            logi("要缓存图像的url : \(url)")
            
            // A> 入组
            group.enter()
            
            // 下载图像
            // 该方法是 SDWebImage的核心方法
            // 图像下载完成会自动保存在沙盒中，文件路径是 URL 的 md5
            // 如果沙盒中已经存在缓存的图像，后续使用SD 通过 URL加载图像，都会加载本地沙盒的图像
            // 不会发起网络请求，同时，回调方法同样会回调，
            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { image, data, _, _, _, _ in
                
                logi("缓存的图像是 \(image), 长度是 \(data?.count)")
                
                length += data?.count ?? 0
                
                group.leave()
                
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            logi("缓存完成，缓存了 \(length / 1024) KB")
            work()
        }
        
    }
}
