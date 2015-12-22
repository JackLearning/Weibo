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
    
   // 配图数组
    var pic_urls:[[String : String]]? {
        didSet {
            
            guard let array = pic_urls else {
                
                return
                
            }
      // 遍历数组
      // 将数组实例化
      imageURLs = [NSURL]()
    for item in array {
    // 相信后端能返回一个url的string
        let urlString = item["thumbnail_pic"]
        // 相信后端给的url 一定能转成url对象
        let url = NSURL(string: urlString!)
        
       // 添加url
        imageURLs!.append(url!)
        
       }
      }
     
    }
    
   // 将配图的数组转换成 url 对象
    var imageURLs:[NSURL]?
    
    var retweeted_status: Status?
    
    
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
    
    if key == "retweeted_status" {
        if let dict = value as? [String : AnyObject] {
            retweeted_status = Status(dict: dict)
            return
        }
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
