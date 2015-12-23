//
//  NetworkTools.swift
//  Weibo
//
//  Created by apple on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

import AFNetworking

let dataErrorDomain = "com.baidu.data.error"

// 枚举任意类型
enum HTTPMethod: String {
   case GET = "GET"
   case POST = "POST"
 }

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
    func requestJSONDict(method:HTTPMethod,urlString:String,parameters:[String : String]?,finished:(dict: [String : AnyObject]?,error: NSError?) ->()) {
        
        if method == HTTPMethod.POST {
        
       // 发送POST请求
        POST(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (_, result) -> Void in
                // 请求成功的回调
                print(result)
                
                guard let dict = result as?[String : AnyObject] else {
                 // 不能转换成字典数据
                 // 执行失败的回调
                // domain:反转的域名 com.baidu.error
                // code : 错误状态码 自定义错误信息 一般使用 负数
                    let myError = NSError(domain: dataErrorDomain, code: -100000, userInfo: [NSLocalizedDescriptionKey : "数据不合法"])
                    
                    print(myError)
                    
                     finished(dict: nil, error: myError)
                    
                    return
                    
                    
                }
                
                
            }) { (_, error) -> Void in
                 // 请求失败的回调
                print(error)
                
                finished(dict: nil, error: error)
                
        }
    }
        
        else {
            
            GET(urlString, parameters: parameters, progress: { (p) -> Void in
                 print(p)
                }, success: { (_, result) -> Void in
                     print(result)
                    
                    guard let dict = result as?[String : AnyObject] else {
                        // 不能转换成字典数据
                        // 执行失败的回调
                        // domain:反转的域名 com.baidu.error
                        // code : 错误状态码 自定义错误信息 一般使用 负数
                        let myError = NSError(domain: dataErrorDomain, code: -100000, userInfo: [NSLocalizedDescriptionKey : "数据不合法"])
                        
                        print(myError)
                        
                        finished(dict: nil, error: myError)
                        
                        return
                    }
                    
                }, failure: { (_, error) -> Void in
                    // 执行失败的回调
                    finished(dict: nil, error: error)
                     print(error)
            })
            
        }
     }
  }
 