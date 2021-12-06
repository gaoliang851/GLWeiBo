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
    /// 如果是被转发的微博，原创微博一定没有图
    var picURLs: [GLStatusPicture]? {
        // 如果有被转发的微博，返回被转发微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 如果都没有,返回nil
        status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    /// 转发微博内容
    var retweetedStatusText: String?
    /// 高度
    var rowHeight: CGFloat = 0
    
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
        pictureViewSize = calcPictureViewSize(count: picURLs?.count)
        
        // 设置转发微博的内容
        retweetedStatusText = "@"
        + (status.retweeted_status?.user?.screen_name ?? "")
        + ":"
        + (status.retweeted_status?.text ?? "")
        
        // 计算row的高度
        updateRowHeight()
    }
    
    func updateRowHeight() {
        // 原创微博的高度 = 顶部间距视图(12) + margin(12) + 头像视图高度(34) + 正文的高度 + 配图视图的高度 + margin(12) + 底部工具栏的视图（38）
        // 转发微博的高度 = 顶部间距视图(12) + margin(12) + 头像视图高度(34) + 正文的高度 + margin(12) + 转发微博正文的高度 + 配图视图的高度 + margin(12) + 底部工具栏的视图（38）
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 38
        
        var height: CGFloat = 0
        
        let orginalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        // 顶部：顶部间距视图(12) + margin(12) + 头像视图高度(34)
        height += margin * 2 + iconHeight
        //正文的高度
        let viewSize = CGSize(width: UIScreen.cz_screenWidth() - 2 * margin, height: CGFloat.greatestFiniteMagnitude)
        if let text = status.text {
            height += (text as NSString).boundingRect(with: viewSize,
                                                      options: [.usesLineFragmentOrigin],
                                                      attributes: [.font:orginalFont],
                                                      context: nil).height
        }
        
        //转发微博
        if status.retweeted_status != nil {
            height += margin
            height += (retweetedStatusText as NSString).boundingRect(with: viewSize,
                                                                     options: [.usesLineFragmentOrigin],
                                                                     attributes: [.font:retweetedFont],
                                                                     context: nil).height
        }
        
        // 配图高度
        height += pictureViewSize.height
        height += margin
        //底部工具栏高度
        height += toolbarHeight
        
        rowHeight = height
        
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
    
    // 单图微博的图片处理
    func updateSignleImageSize(image: UIImage) {
        // 图片的尺寸
        var size = image.size
        // 底部视图的高度 = 图片的高度 + 12
        size.height += GLStatusPictureViewOutterMargin

        pictureViewSize = size
    }
    
}
