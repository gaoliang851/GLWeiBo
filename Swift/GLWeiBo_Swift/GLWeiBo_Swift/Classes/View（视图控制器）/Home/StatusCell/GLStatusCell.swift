//
//  GLStatusCell.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/27.
//

import UIKit

class GLStatusCell: UITableViewCell {
    
    /// 微博视图模型
    var viewModel: GLStatusViewModel? {
        didSet {
            // 微博文本
            stausLabel.text = viewModel?.status.text
            
            // 姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            
            // 设置会员图标 - 直接获取属性，不需要计算
            memberIconView.image = viewModel?.memberIcon
            
            // 设置认证图标
            vipIconView.image = viewModel?.vipIcon
            
            // 设置头像
            let iconUrlString = viewModel?.status.user?.profile_image_url ?? ""
            iconView.cz_setWebImage(urlString: iconUrlString, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            
            // 设置底部工具栏按钮
            toolbar.statusViewModel = viewModel
            
            // 配图视图视图模型
            pictureView.viewModel = viewModel
            
            // 设置转发微博的内容
            retweedStatusLabel?.text = viewModel?.retweetedStatusText
            
            // 设置来源
            sourceLabel.text = viewModel?.status.source
            // 设置创建时间
            // timeLabel.text = viewModel?.status.created_at
        }
    }
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// 微博正文
    @IBOutlet weak var stausLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    /// 底部工具栏
    @IBOutlet weak var toolbar: GLStatusToolBar!
    /// 底部配图视图
    @IBOutlet weak var pictureView: GLStatusPictureView!
    
    /// 被转发微博的正文, 因为该控件可能为空,
    /// 必须使用 `?`
    @IBOutlet weak var retweedStatusLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 异步绘制 - 离屏渲染
        // 该属性对传入-drawLayer:inContext:的CGContext进行改动，
        // 允许CGContext延缓绘制命令的执行以至于不阻塞用户交互。
        // 适用于图层内容需要反复重绘的情况。
        self.layer.drawsAsynchronously = true
    
        //手动启用栅格化
        self.layer.shouldRasterize = true
        // 一定要指定倍数
        self.layer.rasterizationScale = UIScreen.main.scale
        
        //https://www.it610.com/article/1241798950760075264.htm
    }

}
