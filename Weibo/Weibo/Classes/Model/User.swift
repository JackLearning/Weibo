//
//  User.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class User:  NSObject {
    
    // 用户的UID
    var id: Int64 = 0
    
    // 友好显示名称
    var name: String?
    
    // 用户头像地址
    var profile_image_url: String?
    
    // 用户头像的url
    var headURL: NSURL? {
        
        get{
            return NSURL(string: profile_image_url ?? "")
        }
        
    }
    
 // 认证类型，-1：没有认证，0 ，认证用户，2，3，5：企业认证，220：达人
    var verified_type: Int = -1
    
    var verified_type_image:UIImage? {
        
        switch verified_type {
        case -1: return nil
        case  0: return UIImage(named: "avatar_vip")
        case 2,3,5 : return UIImage(named: "avatar_enterprise_vip")
        case 220 :return UIImage(named: "avatar_grassroot")
        default:return nil
            
        }
     }
    
  // 会员等级0-6
    var mbrank: Int = 0
    
    var mbrankImage:UIImage? {
       // 是否有等级
        if mbrank > 0 && mbrank < 7 {
            
         return UIImage(named: "common_icon_membership_level\(mbrank)")
            
        }
        return nil
    }

 // 构造方法 KVC设置值
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    
    
  // 过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    
    // 重写user的description方法 
    override var description: String {
       let keys = ["id","name","profile_image_url","verified_type","mbrank"]
        
        return dictionaryWithValuesForKeys(keys).description
        
    }
   
}

















