//
//  StatusRetweetedView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SnapKit

// 转发微博  转发微博正文 + 配图正文

class StatusRetweetedView: UIView {

    override init(frame: CGRect) {
         super.init(frame: frame)
        setupUI()
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK: 设置页面 和布局
    private func setupUI() {
        
        addSubview(retweetedLabel)
        addSubview(pictureView)
     // 添加约束
        retweetedLabel.snp_makeConstraints { (make) -> Void in
             make.left.top.equalTo(self).offset(StatusCellMarigin)
        }
        
      pictureView.snp_makeConstraints { (make) -> Void in
        
          make.top.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMarigin)
         make.left.equalTo(retweetedLabel.snp_left)
        
        
        }
        
        
        
        
        
    }
    
    
    
  // 懒加载所有子视图   
    private lazy var retweetedLabel: UILabel = UILabel(title: "我是转发微博", color: UIColor.darkGrayColor(), fontSize: 14, margin: StatusCellMarigin)
    
    // 配图视图
    private lazy var pictureView :StatusPictureView = StatusPictureView()
    
    
    
    
    
    
    
    
    
    
    
}
