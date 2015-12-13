//
//  MaintabBar.swift
//  Weibo
//
//  Created by apple on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class MaintabBar: UITabBar {

    //MainTabBar 既支持 手码创建  也支持 xib/ sb创建
    
    //UIView的默认的构造方法
    //重写父类的构造方法
    
    override init(frame: CGRect) {
         super.init(frame: frame)
    
}

    //通过xib / sb创建 视图会调用这个方法
    //如果实现了 init(frame) 意味当前这个类 默认支持 手码创建 不支持xib创建 不会调用init(decoder
    //创建tabbar 调用了这个方法 就一定是 xib / sb中创建的
    required init?(coder aDecoder: NSCoder) {
        //表示 是致命的错误 默认实现报错 想不报错就实现对应的方法
        //当从xib / sb加载该空间 程序就会报错
        
         //fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
    }
  
  
    
    // 在这个方法中设置所有子视图的frame
    override func layoutSubviews() {
        // 调用父类的方法
        super.layoutSubviews()
        // 修改所有tabbarButton的frame 将中间的位置留出
        let w = self.bounds.width / 5
        
        let h = self.bounds.height
        
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        
        
        // 遍历所有子视图 修改大小
        // 定义索引系数
        var index:CGFloat = 0
        for subView in subviews {
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                
                // 修改frame
                // //dx: 水平方向的位移  dy:垂直方向的位移
                
                subView.frame = CGRectOffset(rect, index * w, 0)
                // 默认把在最后空出位置
                // 因此要处理index
                index += (index == 1 ? 2 : 1)
                
                
            }
            
        }
        
        
    }
      
}