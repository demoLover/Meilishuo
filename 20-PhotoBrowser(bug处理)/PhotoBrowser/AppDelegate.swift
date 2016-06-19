//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }
}


// 根据一个图片计算放大之后的frame
func calculateImageViewFrame(image : UIImage) -> CGRect {
    let imageViewW = UIScreen.mainScreen().bounds.width
    let imageViewH = imageViewW / image.size.width * image.size.height
    let x : CGFloat = 0
    let y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
    
    return CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
}