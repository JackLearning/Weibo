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
    
    // 用户头像的url
    var headURL: NSURL? {
        
        let url = NSURL(string: userAccount?.avatar_large ?? "")
        
        return url
    }
    
    
    
    // 用户名
    var userName:String? {
        
        return userAccount?.name
    }
    
    var token: String? {
        return userAccount?.access_token
    }
    
 
    // MARK :加载用户的token(请求标识)
    func loadAccessToken(code:String,finished:(isSuccess:Bool)->()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":client_id,"client_secret":client_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri]
        
        NetworkTools.sharedTools.requestJSONDict(.POST, urlString: urlString, parameters: parameters) { (dict, error) -> () in
            
           print(dict)
            if error != nil {
               // 请求失败
                // 执行失败的回调
                finished(isSuccess: false)
                return
          }
            
            // 字典转模型
            let userAccount = UserAccount(dict: dict!)
            
            self.loadUserInfo(userAccount, finished:finished)
            
        }
        
    }
    
    
    
// MARK: 获取用户信息

    // MARK:获取用户信息
    private func loadUserInfo(account: UserAccount,finished: (isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        // 制定中不能够存放nil [NSNull null]
        if let token = account.access_token,userId = account.uid {
            
         let parameters = ["access_token": token, "uid": userId]
            
         NetworkTools.sharedTools.requestJSONDict(.GET, urlString: urlString, parameters: parameters, finished: { (dict, error) -> () in
            
            if error != nil {
                // 执行失败的回调
                finished(isSuccess: false)
                return
            }
       // 获取用户信息
            let avatar_large = dict!["avatar_large"] as! String
            let name = dict!["name"] as! String
            //给account 对象的属性做赋值操作
            account.name = name
            account.avatar_large = avatar_large
            //获取用户信息的完整自定义对象
            //存储自定义对象
            account.saveAccount()
            //执行成功的回调
            finished(isSuccess: true)
            
        })
           
     }
        
    }
}

 
     