//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    
    // MARK:- 定义的属性
    lazy var shops : [Shop] = [Shop]()
    lazy var photoBrowserAnimator : PhotoBrowserAnimator = PhotoBrowserAnimator()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(0)
    }
}


// MARK:- 网络请求的方法
extension HomeViewController {
    func loadData(offSet : Int) {
        NetworkTools.shareIntance.loadHomeData(offSet) { (resultArray, error) -> () in
            // 1.错误校验
            if error != nil {
                return
            }
            
            // 2.取出可选类型中的数据
            guard let resultArray = resultArray else {
                return
            }
            
            // 3.遍历数组,将数据中的字典转成模型对象
            for dict in resultArray {
                let shop = Shop(dict: dict)
                self.shops.append(shop)
            }
            
            // 4.刷新表格
            self.collectionView?.reloadData()
        }

    }
}


// MARK:- collectionView的数据源方法和代理方法
extension HomeViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shops.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeViewCell
        
        // 2.给cell设置数据
        cell.shop = shops[indexPath.row]
        
        
        // 3.判断是否是最后一个cell即将出现
        if indexPath.row == shops.count - 1 {
            loadData(shops.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 1.创建图片浏览器控制器
        let photoBrowser = PhotoBrowserController()
        
        // 2.设置控制器相关的属性
        photoBrowser.indexPath = indexPath
        photoBrowser.shops = shops
        photoBrowserAnimator.indexPath = indexPath
        photoBrowserAnimator.presentedDelegate = self
        photoBrowserAnimator.dismissDelegate = photoBrowser
        
        // 3.设置photoBrowser的弹出动画
        photoBrowser.modalPresentationStyle = .Custom
        photoBrowser.transitioningDelegate = photoBrowserAnimator
        
        // 4.弹出控制器
        presentViewController(photoBrowser, animated: true, completion: nil)
    }
}


// MARK:- 实现presentedDelegate的代理方法
extension HomeViewController : PresentedProtocol {
    func getImageView(indexPath: NSIndexPath) -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.设置图片
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! HomeViewCell
        imageView.image = cell.imageView.image
        
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func getStartRect(indexPath: NSIndexPath) -> CGRect {
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? HomeViewCell else {
            return CGRectZero
        }
        
        // 2.将cell的frame转换成所有屏幕的frame
        let startRect = collectionView!.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        return startRect
    }
    
    func getEndRect(indexPath: NSIndexPath) -> CGRect {
        // 1.获取当前正在显示的cell
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! HomeViewCell
        
        // 2.获取image对象
        let image = cell.imageView.image
        
        return calculateImageViewFrame(image!)
    }
}


