//
//  UIColor + Extension.swift
//  Weibo
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit

extension UIColor {
    
    //返回一个随机色
    class func randomColor() -> UIColor {
        
        let r = CGFloat(random() % 256) / 255.0
        let g = CGFloat(random() % 256) / 255.0
        let b = CGFloat(random() % 256) / 255.0
        return  UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
