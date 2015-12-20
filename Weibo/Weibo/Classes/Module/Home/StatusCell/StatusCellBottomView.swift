//
//  StatusCellBottomView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {
   
    //MARK 定义外部模型属性
    // MARK 重写构造方法
    override init(frame: CGRect) {
         super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    // 设置页面和布局
    private func setupUI() {
        
        addSubview(retweetedBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        
    }
    
 // MARK :懒加载所有子视图
 // 转发的按钮
    
    private lazy var retweetedBtn:UIButton = UIButton(title: "转发", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_retweet")
    
    private lazy var  commentBtn:UIButton = UIButton(title: "评论", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_comment")
    
    private lazy var  likeBtn:UIButton = UIButton(title: "喜欢", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_unlike")
    
   
}
