//
//  GLStatusToolBar.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import UIKit

/// 微博底部按钮栏
class GLStatusToolBar: UIView {
    
    var statusViewModel: GLStatusViewModel? {
        didSet {
            retweetButton.setTitle(statusViewModel?.retweetStr, for: [])
            commentButton.setTitle(statusViewModel?.commentStr, for: [])
            likeButton.setTitle(statusViewModel?.likeStr, for: [])
        }
    }
    
    /// 转发按钮
    @IBOutlet weak var retweetButton: UIButton!
    /// 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞按钮
    @IBOutlet weak var likeButton: UIButton!
}
