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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
