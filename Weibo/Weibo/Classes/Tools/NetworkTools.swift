//
//  NetworkTools.swift
//  Weibo
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    // 单例对象
    static let sharedTools:NetworkTools = {
       // 设置baseURL
        let urlString = "https://api.weibo.com/"
        let url = NSURL(string: urlString)
        let tools = NetworkTools(baseURL: url)
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
        
    }()
    
  // 网络请求的核心方法封装
    func requestJSONDict(urlString:String,parameters:[String : String]?,finished:() ->()) {
        
       // 发送POST请求
        POST(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (_, result) -> Void in
                // 请求成功的回调
                print(result)
                
                
            }) { (_, error) -> Void in
                 // 请求失败的回调
                print(error)
        }
        
        
    }
  
}

















