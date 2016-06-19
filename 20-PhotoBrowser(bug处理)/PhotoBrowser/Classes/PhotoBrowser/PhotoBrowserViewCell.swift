//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewCell: UICollectionViewCell {
    // MARK:- 定义属性
    var shop : Shop? {
        didSet {
            // 1.nil值校验
            guard let shop = shop else {
                return
            }
            
            // 2.取出image对象
            var image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(shop.q_pic_url)
            if image == nil {
                image = UIImage(named: "empty_picture")
            }
            
            // 3.根据图片计算imageView的frame
            imageView.frame = calculateImageViewFrame(image)
            
            // 4.设置imageView的图片
            guard let url = NSURL(string: shop.z_pic_url) else {
                imageView.image = image
                return
            }
            
            imageView.sd_setImageWithURL(url, placeholderImage: image) { (image, _, _, _) -> Void in
                self.imageView.frame = calculateImageViewFrame(image)
            }
        }
    }
    
    // MARK:- 懒加载属性
    lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    // required : 如果有实现父类的某一个构造函数,那么必须同时实现使用required修饰的构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.addSubview(imageView)
    }
}








