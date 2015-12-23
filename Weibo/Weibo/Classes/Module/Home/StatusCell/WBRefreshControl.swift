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
        
        setupUI()
        
        //设置颜色
        backgroundColor = UIColor.randomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // 设置页面和布局
    private func setupUI() {
        
      // 添加子视图
        addSubview(tipLabel)
        addSubview(arrowIcon)
        addSubview(loadIcon)
        
    // 设置约束
        tipLabel.snp_makeConstraints { (make) -> Void in
             make.centerX.equalTo(self.snp_centerX).offset(15)
             make.centerY.equalTo(self.snp_centerY)
        }
        
         arrowIcon.snp_makeConstraints { (make) -> Void in
             make.right.equalTo(tipLabel.snp_left).offset(-5)
            make.centerY.equalTo(tipLabel.snp_centerY)
        }
        
         loadIcon.snp_makeConstraints { (make) -> Void in
             make.center.equalTo(arrowIcon)
        }
        
    }
    
    
   //MARK:懒加载所有的子视图
    private lazy var arrowIcon:UIImageView = UIImageView(image: UIImage(named:"timeline_icon_retweet"))
    
    private lazy var tipLabel:UILabel = UILabel(title: "下拉起飞", color: UIColor.randomColor(), fontSize: 14)
    
    private lazy var loadIcon :UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
}



 