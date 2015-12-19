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
    
   // 构造方法 KVC设置值
    init(dict:[String:AnyObject]) {
        
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    // 过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
}
