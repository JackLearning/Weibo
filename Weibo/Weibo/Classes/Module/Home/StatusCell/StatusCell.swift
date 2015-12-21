//
//  StatusCell.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SnapKit

class StatusCell: UITableViewCell {
    
    // 定义微博模型属性
    var status:Status? {
        didSet {
       // 给顶部视图 设置模型数据
            topView.status = status
     }
  }
    
    // cell 入口
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// 自定义cell
    private func setupUI() {
     // 使用contentView 添加子视图
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        contentView.addSubview(retweetedView)
        
        
        
        
     // 设置约束
        
        topView.snp_makeConstraints { (make) -> Void in
            
        // 设置高度
           //  make.height.equalTo(50)
            make.top.left.right.equalTo(contentView)
            
            
        }
        
        // 设置转发微博的约束
        retweetedView.snp_makeConstraints { (make) -> Void in
             make.left.right.equalTo(contentView)
             make.top.equalTo(topView.snp_bottom)
             make.height.equalTo(50)
            
         }
        
        
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self)
            make.top.equalTo(retweetedView.snp_bottom)
            make.height.equalTo(40)
            
        }
            
       // 给contentView设置约束 非常的关键
        
      contentView.snp_makeConstraints { (make) -> Void in
         make.top.left.right.equalTo(self)
        make.bottom.equalTo(bottomView.snp_bottom)

        }
          
   }
    
// 懒加载topView
    
    // 转发微博
    private lazy var retweetedView:StatusRetweetedView = StatusRetweetedView()
    
    
    private lazy var topView:StatusCellTopView = StatusCellTopView()
    
    private lazy var bottomView:StatusCellBottomView = StatusCellBottomView()
    
    
}
