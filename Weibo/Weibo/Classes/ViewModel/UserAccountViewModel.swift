//
//  UserAccountViewModel.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import AFNetworking
class UserAccountViewModel: NSObject {
    
    // 封装网络请求的业务逻辑
    var userAccount: UserAccount?
    
    override init() {
         userAccount = UserAccount.loadAccount()
        super.init()
    }
    
   // 计算属性 判断用户是否登录
    var userLogin:Bool {
        
      return userAccount?.access_token != nil
    }
    
    
    // 用户名
    var userName:String? {
        
        return userAccount?.name
    }
    
    
    
 
    // MARK :加载用户的token(请求标识)
    func loadAccessToken(code:String,finished:(isSuccess:Bool)->()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":client_id,"client_secret":client_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri]
        
        let AFN = AFHTTPSessionManager()
        AFN.responseSerializer.acceptableContentTypes?.insert("text/plain")
        AFN.POST(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (_, result) -> Void in
                
                // 获取token 成功
                // 获取用户信息
                if let dict = result as?[String : AnyObject] {
                    
                    let userAccount = UserAccount(dict: dict)
                    
                    self.loadUserInfo(userAccount,finished:finished)
                    
                }
                
            }) { (_, error) -> Void in
                 print(error)
                
                finished(isSuccess: false)
        }
        
    }
    
    
    
// MARK: 获取用户信息
    private func loadUserInfo(account:UserAccount,finished:(isSuccess:Bool)->()) {
        
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 字典中不能放nil
        if let token = account.access_token,userId = account.uid {
            
            
            let parameters = ["access_token":token,"uid":userId]
            
            let AFN  = AFHTTPSessionManager()
            
            AFN.GET(urlString, parameters: parameters, progress: { (_) -> Void in
                
                }, success: { (_, result) -> Void in
                    
                    
                    if let dict  = result {
                      // 获取用户信息
                        let avatar_large = dict["avatar_large"] as! String
                        let name = dict["name"] as! String
                        
                        // 给account 对象的属性赋值
                        account.name = name
                        account.avatar_large = avatar_large
                        
                        // 获取用户信息的完整自定义对象
                        // 存储自定义对象
                        account.saveAccount()
                        // 执行成功的回调
                        finished(isSuccess: true)
                        
                    }
                    
                    
                }, failure: { (_, error) -> Void in
                     print(error)
                    
                    finished(isSuccess: false)
                    
                    
            })
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
