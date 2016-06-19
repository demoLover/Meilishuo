//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var shop : Shop?  {
        didSet {
            // 0.校验模型是否有值
            guard let shop = shop else {
                return
            }
            
            // 1.取出图片的URLString
            guard let url = NSURL(string: shop.q_pic_url) else {
                return
            }
            
            // 2.设置图片
            let placeHolderImage = UIImage(named: "empty_picture")
            imageView.sd_setImageWithURL(url, placeholderImage: placeHolderImage)
        }
    }
}
