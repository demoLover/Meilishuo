//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

class PhotoBrowserController: UIViewController {
    
    // MARK:- 定义的属性
    var indexPath : NSIndexPath?
    var shops : [Shop]?
    let PhotoBrowserCellID = "PhotoBrowserCellID"
    
    // MARK:- 懒加载的属性
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserLayout())
    lazy var closeBtn : UIButton = UIButton()
    lazy var saveBtn : UIButton = UIButton()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.设置图片之间的间距
        view.frame.size.width += 15
        
        // 1.设置UI界面
        setupUI()
        
        // 2.滚动到对应的位置
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
    }
    
}


// MARK:- 设置UI界面的内容
extension PhotoBrowserController {
    func setupUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 2.设置子控件的位置
        collectionView.frame = view.bounds
        
        let margin : CGFloat = 20
        let btnW : CGFloat = 90
        let btnH : CGFloat = 32
        let y : CGFloat = UIScreen.mainScreen().bounds.height - btnH - margin
        closeBtn.frame = CGRect(x: margin, y: y, width: btnW, height: btnH)
        let x : CGFloat = UIScreen.mainScreen().bounds.width - btnW - margin
        saveBtn.frame = CGRect(x: x, y: y, width: btnW, height: btnH)
        
        // 3.设置btn相关的属性
        prepareBtn()
        
        // 4.设置collectionView相关的属性
        prepareCollectionView()
    }
    
    func prepareBtn() {
        setupBtn(closeBtn, title: "关 闭", action: "closeBtnClick")
        setupBtn(saveBtn, title: "保 存", action: "saveBtnClick")
    }
    
    func setupBtn(btn : UIButton, title : String, action : String) {
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        btn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        // Selector : 1.Selector("方法名称") 2."方法名称"
        btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        // 获取某一个类的class UICollectionViewCell.self
        collectionView.registerClass(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCellID)
    }
}


// MARK:- 监听事件
extension PhotoBrowserController {
    /*
     1.事件监听的本质:发送消息
        发送消息的过程: 1.将方法包装成SEL 2.去类中的方法列表中找到对应的方法 3.找到IMP的函数指针 4.执行函数
     2.在swift中,如果将一个函数修饰成private.那么该函数不会被放入到消息列表
     3.只有在private前加上@objc,那么该方法还是会被添加到消息列表
    */
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClick() {
        // 1.取出当前正在显示的图片
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2.保存图片
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}


// MARK:- collectionView的数据源和代理方法
extension PhotoBrowserController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ?? : 处理可选链,如果可选链中有一个可选类型没有值,那么直接使用 ?? 后面的值
        return shops?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellID, forIndexPath: indexPath) as! PhotoBrowserViewCell
        
        // 2.设置cell的内容
        cell.shop = shops![indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        closeBtnClick()
    }
}


// MARK:- 实现dismissProtocol的代理方法
extension PhotoBrowserController : DismissProtocol {
    func getImageView() -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.设置imageView的image
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        imageView.image = cell.imageView.image
        
        // 3.设置imageView的frame
        imageView.frame = cell.imageView.frame
        
        // 4.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    func getIndexPath() -> NSIndexPath {
        // 1.获取正在显示的cell
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        
        return collectionView.indexPathForCell(cell)!
    }
}





