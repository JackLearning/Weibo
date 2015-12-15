//
//  UserAccount.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    
    // 自定义对象归档操作
    // 用于调用access_token,接口获取授权后access token
    var access_token: String?
//    access_token的生命周期  单位是秒
    var expires_in:NSTimeInterval = 0
    // 当前授权用户的UID
    var uid:String?
    // 友好显示名称
    var name:String?
    // 用户头像地址
    var avatar_large:String?
    
    
    
    // kvc 给对象设置初始值
    init(dict: [String : AnyObject]) {
        // 构造对象的最后一步
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
    
    
    
    

}
