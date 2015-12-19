//
//  UILabel+Extension.swift
//  Weibo
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

//swift 文件 没有继承自任何父类  就是一个最顶级的类   -> AnyObject  才能够包括

extension UILabel {
    
    convenience init(title:String,color:UIColor,fontSize:CGFloat) {
        // 完成实例化
        self.init()
        // 可以设置属性了
        text = title
        textColor = color
        textAlignment = .Center
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        sizeToFit()
    }
  }




