//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

class Shop: NSObject {
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
