//
//  UIView+ViewController.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/24.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

//通过响应者链条 将试图的导航视图控制 找到

extension UIView {
    
    
    func navController() ->UINavigationController? {
        
        // 获取当前控件的下一个响应者
        var next = nextResponder()
        // 遍历响应者链条
        repeat {
        if let nextObj = next as? UINavigationController {
        
         return nextObj
        
        }
      // 获取下一个响应者的下一个响应者
        next = next?.nextResponder()
        
    } while(next != nil)
        
        return nil
        
  }
      
}