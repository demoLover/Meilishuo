//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

class PhotoBrowserLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        // 1.设置layout相关的属性
        itemSize = (collectionView?.bounds.size)!
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        // 2.设置collectionView的属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
    }
}
