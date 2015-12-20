//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit


extension UIButton {
    
    /**
    实例化一个 有背景视图 + title 的自定义按钮
    
    - parameter title:         按钮的文案
    - parameter backImageName: 背景图片
    - parameter fontSize:      文案的font大小
    - parameter color:         文案的颜色
    */
   
    convenience init(title:String,backImageName:String?,fontSize:CGFloat,color:UIColor, imageName: String? = nil ) {
    
        // 需要调用本类的指定的构造函数, 实例化自己
        self.init()
        
        if imageName != nil {
            
            setImage(UIImage(named: imageName!), forState: .Normal)
            
        }
           if backImageName != nil {
            
            setBackgroundImage(UIImage(named: backImageName!), forState: .Normal)
        }
       setTitle(title, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        setTitleColor(color, forState: .Normal)
        sizeToFit()
        
        
        
    }
    
    
    /**
    返回一个 有背景视图 + image 按钮的样式
    
    - parameter imageName:     按钮的图片名称
    - parameter backImageName: 按钮背景图片名称
    */
    
    convenience init(imageName: String,backImageName: String) {
        self.init()
        
       // 自定义样式
        setImage(UIImage(named:imageName), forState: .Normal)
        
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        setBackgroundImage(UIImage(named: backImageName), forState: .Normal)
        
        setBackgroundImage(UIImage(named:backImageName + "_highlighted"), forState: .Highlighted)
        
        sizeToFit()
        
    }
    
    
    
}

