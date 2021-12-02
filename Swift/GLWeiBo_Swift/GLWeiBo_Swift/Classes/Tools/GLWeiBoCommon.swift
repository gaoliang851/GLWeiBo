//
//  GLWeiBoCommon.swift
//  GLWeiBo_Swift
//
//  Created by mac on 2021/10/27.
//

import Foundation

//MARK: - 全局的通知定义

// 用户应该登录的通知
let GLUserShouldLoginNotification = "GLUserShouldLoginNotification"
// 用户登录成功的通知
let GLUserLoginSuccessNotification = "GLUserLoginSuccessNotification"

//MARK: - 应用程序信息
// 应用程序ID
let GLAppKey = "2913690478"
// 应用程序加密信息
let GLAppSecret = "52dd305c7269cad9129fc21e88393e61"
// 回调地址
let GLRedirectURI = "https://www.baidu.com"


// MARK: - 微博配图视图常量
// 配图视图外侧的间距
let GLStatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像视图的间距
let GLStatusPictureViewInnerMargin = CGFloat(3)
// 视图的宽度的宽度
let GLStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * GLStatusPictureViewOutterMargin
// 每个 Item 默认的宽度
let GLStatusPictureItemWidth = (GLStatusPictureViewWidth - 2 * GLStatusPictureViewInnerMargin) / 3
