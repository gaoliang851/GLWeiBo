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
解决：在属性前面加上@objc，或者在类的上面加上@objcMembers。
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
    
    var user: GLUser?
    
    /// 重写 description 属性
    override var description: String {
        yy_modelDescription()
    }
}
