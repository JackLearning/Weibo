//
//  Status.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit

class Status: NSObject {

    // 微博的创建时间
    var created_at: String?
    // 微博ID NSInteger  在iPhone 5c以下的设备上 会导致 整型数据被截
     var id: Int64 = 0
    // 微博信息内容
    var text:String?
    // 微博来源
    var source:String?
    
    // 用户模型
    var user: User?
    
   // 构造方法 KVC设置值
    init(dict: [String : AnyObject]) { 
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
   override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
         if let dict = value as? [String : AnyObject] {
                user = User(dict: dict)
                print(user)
          }
        // 注意 需要加return 不然上面字典转模型 就白转了
            return
            
       }
        
    // 给其他属性设置值
    super.setValue(value, forKey: key)
        
  }
    
    
    // 过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
 
  // 重写user 的description方法
    override var description:String {
        
        let keys = ["created_at","id","text","source","user"]
        return dictionaryWithValuesForKeys(keys).description
        
    }
    
}
