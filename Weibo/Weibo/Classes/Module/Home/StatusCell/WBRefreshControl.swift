//
//  WBRefreshControl.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

// 刷新控件的高度
private let RefreshViewHeight: CGFloat = 60


class WBRefreshControl: UIControl {

   //MARK:定义外部模型属性
   // MARK:重写构造方法
    override init(frame: CGRect) {
         // 在视图内部确定frame
        let rect = CGRect(x: 0, y: -RefreshViewHeight, width: screenW, height: RefreshViewHeight)
        super.init(frame: rect)
        
        //设置颜色
        backgroundColor = UIColor.randomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // 设置页面和布局
    private func setupUI() {
        
    }
    
    
   //MARK:懒加载所有的子视图
    
    
    
    
    
}
