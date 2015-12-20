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
        
     // 设置约束
        
        topView.snp_makeConstraints { (make) -> Void in
            
        // 设置高度
           //  make.height.equalTo(50)
            make.top.left.right.equalTo(contentView)
            
            
        }
   }
    
// 懒加载topView
    
    private lazy var topView:StatusCellTopView = StatusCellTopView()
    
    
}
