//
//  UserAccount.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    
    // 自定义对象归档操作
    // 用于调用access_token,接口获取授权后access token
    var access_token: String?
//    access_token的生命周期  单位是秒
    var expires_in:NSTimeInterval = 0 {
        
        didSet {
            
            //当过期时间一旦被设置的时候  就立即设置expires_date\
            expires_date = NSDate(timeIntervalSinceNow: expires_in)

            
        }
    }
    // 当前授权用户的UID
    var uid:String?
    // 友好显示名称
    var name:String?
    // 用户头像地址
    var avatar_large:String?
    
    // token 的过期时间 开发者账号的token的有效期 是 5年  普通用户的账号有效期 是 3天
    
    var expires_date:NSDate?
    
    
    
    
    // kvc 给对象设置初始值
    init(dict: [String : AnyObject]) {
        // 构造对象的最后一步
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    // 重写打印对象的方法
    override var description:String {
        
        let keys = ["access_token","expires_in","uid","name","avatar_large","expires_date"]
        
        return dictionaryWithValuesForKeys(keys).description
        
        
    }
    
    
    
    
    
    // 保存自定义对象
    func saveAccount(){
        
        //字符串拼接路径的方法 在 Xcode 7中 被搞丢了  需要转换为 NSString
        // String <-> NSString  [Key: Value] <-> NSDictnory  [xxx,xxx] <-> NSArray  在类型转换的时候 不需要考虑  ? 还是 !
        let path =  (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("account.plist")
       // print(path)
        
        // 保存自定义对象
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
        
        
    }
    
    
    // class func 表示类方法
    class func loadAccount() ->UserAccount? {
        
        // 从磁盘解读数据
        let path =  (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("account.plist")
        
        
    if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as?UserAccount {
            
            //  token的有效期要做判断 如果过期 返回nil
            if account.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                
                return account
            }
            
            
        }
        
        
       return nil
        
        
    }
    
    
    
   // 解挡操作 将磁盘中的二进制数据 转成自定义对象  
    
    required init?(coder aDecoder:NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        
    }
    
    
    
    
    
  // 归档操作 将自定义对象 转成二进制,和序列化类似
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        
    }
    
    

}
