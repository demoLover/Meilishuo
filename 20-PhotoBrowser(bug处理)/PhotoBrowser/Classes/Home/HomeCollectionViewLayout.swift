//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

class HomeCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        // 0.计算一些常量和变量
        let margin : CGFloat = 10
        let itemWH = (UIScreen.mainScreen().bounds.width - 4 * margin) / 3
        
        // 1.设置布局
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        
        // 2.设置collectionView的内边距
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64, left: margin, bottom: margin, right: margin)
    }
}
