//
//  StatusListViewModel.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class StatusListViewModel: NSObject {
    
    //since_id实现下拉刷新 新的微博的字段
    class func loadHomePageData(since_id:Int64,max_id:Int64,finished: (statuses: [Status]?) ->()) {
        // 实现网络请求
        // get 请求
        let urlString = "2/statuses/home_timeline.json"
        // 判断token 是否为空
        guard let token = UserAccountViewModel().token else {
            print("token 为空")
           SVProgressHUD.showInfoWithStatus("请重新登录")
            return
    }
        
        var parameters = ["access_token" : token]
        // 判断since_id 是否大于0
        if since_id > 0 {
            parameters["since_id"] = "\(since_id)"
        }
        
        if max_id > 0 {
            parameters["max_id"] = "\(max_id - 1)"
        }
        
        NetworkTools.sharedTools.requestJSONDict(.GET, urlString: urlString, parameters: parameters) { (dict, error) -> () in
            if error != nil {
                //执行失败的回调的
                SVProgressHUD.showInfoWithStatus("您的网络正在睡觉,请稍后...")
                finished(statuses: nil)
                return
            }
            
            //请求成功
            if let array = dict!["statuses"] as? [[String : AnyObject]] {
                //                    print(array)
                //TODO: 遍历数组中 所有的字典 做字典转模型的操作
                var list = [Status]()
                for item in array {
                    let s = Status(dict: item)
                    list.append(s)
                }
                
                //执行成功的回调
                finished(statuses: list)
            }
        }
        
    }
    
}
