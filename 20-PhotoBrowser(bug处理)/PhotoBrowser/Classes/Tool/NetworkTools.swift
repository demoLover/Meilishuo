//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    // 将类设计成单利对象
    static let shareIntance : NetworkTools = {
        let tool = NetworkTools()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tool
    }()
    
    
    
    // [[String : NSObject]] 字典数组
    /*
     (resultArray : [[String : NSObject]]?, error : NSError?) -> ()
        1.闭包有两个参数,一个回调的数据,一个是回调的错误
        2.闭包的第一个参数是一个字典数组: 数组中存放都是字典类型
    */
    func loadHomeData(offSet : Int, finishedCallback : (resultArray : [[String : NSObject]]?, error : NSError?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=\(offSet)&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
        
        // 2.发送网络请求
        GET(urlString, parameters: nil, progress: nil, success: { (_, result) -> Void in
                // 1.将AnyObject?转成字典类型
                guard let resultDict = result as? [String : NSObject] else {
                    print("没有拿到正确的数据")
                    return
                }
                
                // 2.从字典中将数组取出
                let dictArray = resultDict["data"] as? [[String : NSObject]]
                
                // 3.将数据回调出去
                finishedCallback(resultArray: dictArray, error: nil)
            
            }) { (_, error) -> Void in
                finishedCallback(resultArray: nil, error: error)
        }
    }
}













