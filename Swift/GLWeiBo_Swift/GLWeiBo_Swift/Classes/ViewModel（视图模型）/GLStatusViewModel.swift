//
//  GLStatusViewModel.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import YYModel
import UIKit

/// 单条微博的视图模型
class GLStatusViewModel: CustomStringConvertible {
    /// 微博模型
    var status: GLStatus
    /// 会员图标
    var memberIcon: UIImage?
    /// 认证图标
    var vipIcon: UIImage?
    /// 转发字符串
    var retweetStr: String?
    /// 评论字符串
    var commentStr: String?
    /// 点赞字符串
    var likeStr: String?
    /// 微博配图的大小
    var pictureViewSize = CGSize()
    
    /// 单条微博的视图模型的构造器
    /// - Parameter model: 微博model
    init(model: GLStatus) {
        status = model
        
        /// 设置会员图标
        let mbrank = model.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank < 7 {
            let imageName = "common_icon_membership_level\(mbrank)"
            memberIcon = UIImage(named: imageName)
        }
        
        /// 设置认证图标
        let verifiend_type = model.user?.verifiend_type ?? -1
        switch verifiend_type {
        case 0: //认证用户
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5: //企业用户
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220: //达人
            vipIcon = UIImage(named: "avatar_grassroot")
        default: break
        }
        
        // 设置转发字符串
        retweetStr = countString(count: model.reposts_count, defaultString: "转发")
        // 设置评论字符串
        commentStr = countString(count: model.comments_count, defaultString: "评论")
        // 点赞
        likeStr = countString(count: model.attitudes_count, defaultString: "赞")
        
        // 计算配图视图大小
        pictureViewSize = calcPictureViewSize(count: model.pic_urls?.count)
    }
    
    
    /// 数字转字符
    /// 规则：==0，显示默认字符串
    /// <10000,显示原数字
    /// >10000,显示x.xx万
    /// - Parameters:
    ///   - count: count
    ///   - defaultString: 默认字符串
    /// - Returns: 字符串
    private func countString(count: Int,defaultString: String) -> String {
        if count == 0 {
            return defaultString
        }
        
        if count < 10000 {
            return "\(count)"
        }
        
        // count > 10000
        return String(format: "%.02f 万", Double(count) / 10000)
    }
    
    
    /// 计算指定数量的图片对应的配图视图的大小
    /// - Parameter count: 配图数量
    /// - Returns: 配图视图的大小
    private func calcPictureViewSize(count: Int?) -> CGSize {
        if count == 0 || count == nil {
            return CGSize()
        }
        
        // 计算行
        /**
            1 2 3 = 0 1 2 / 3 = 0 + 1 = 1
            4 5 6 = 3 4 5 / 3 = 1 + 1 = 2
            7 8 9 = 6 7 8 / 3 = 2 + 1 = 3
        */
        let row = CGFloat((count! - 1) / 3 + 1)
        // 计算高度
        var height = GLStatusPictureViewOutterMargin // 顶部空白一个距离
        height += row * GLStatusPictureItemWidth // 行 * 行高
        height += (row - 1) * GLStatusPictureViewInnerMargin
        
        return CGSize(width: GLStatusPictureViewWidth, height: height)
    }
    
    var description: String {
        status.description
    }
    
}
