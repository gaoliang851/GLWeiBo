//
//  GLStatus.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/13.
//

import UIKit
import YYModel

/*
问题：使用YYModel和MJExtension的时候发现正常使用字典转模型怎么都无法实现,转换后的模型一直为nil?
解决：在属性前面加上@objc，或者在类的上面加上 @objcMembers。
原因是因为在 Swift4 中继承 NSObject 的 swift class 不再默认全部 bridge 到 OC。
*/

/// 微博数据模型
/// 使用YYModel字典转模型的类需要继承自NSObject
@objcMembers
class GLStatus: NSObject {
    
    /// 微博ID
    /// Int 类型在64位上是64位，32位上是32位
    var id: Int64 = 0
    /// 微博信心内容
    var text: String?
    /// 微博作者
    var user: GLUser?
    /// 微博配图模型数组
    var pic_urls: [GLStatusPicture]?
    /// 原创微博
    var retweeted_status: GLStatus?
    
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 点赞数
    var attitudes_count: Int = 0
    /// 重写 description 属性
    override var description: String {
        yy_modelDescription()
    }
    
    /// 类函数 -> 告诉第三方框架 YY_Model 如果遇到数组类型的属性，数组中存放的对理想是什么类？
    /// NSArray 中保存对象的类型通常是 `id` 类型
    /// OC 中泛型是 Swift 退出后，苹果为了兼容给 OC 增加的
    /// 从运行时角度，仍然不知道数组中应该存放什么类型的对象
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        ["pic_urls":GLStatusPicture.self]
    }
}
