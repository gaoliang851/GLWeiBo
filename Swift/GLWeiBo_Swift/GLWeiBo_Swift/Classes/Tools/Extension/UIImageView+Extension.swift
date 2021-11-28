//
//  UIImageView+Extension.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/28.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    /// 从网络加载图片，隔离SDWebImage
    /// - Parameters:
    ///   - urlString: 地址
    ///   - placeholderImage: 占位图像
    ///   - isAvatar: 是否是头像
    func cz_setWebImage(urlString: String,placeholderImage: UIImage?,isAvatar: Bool = false) {
        
        guard let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { [weak self] (image,_,_,_) in
            if isAvatar {
                self?.image = image?.cz_avatarImage(size: self?.bounds.size)
            }
        }
    }
    
}
