//
//  StatusCellBottomView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SnapKit

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
        
    // 设置约束
        
     retweetedBtn.snp_makeConstraints { (make) -> Void in
         make.left.top.bottom.equalTo(self)

        }
      commentBtn.snp_makeConstraints { (make) -> Void in
        make.left.equalTo(retweetedBtn.snp_right)
        make.top.bottom.equalTo(self)
        make.width.equalTo(retweetedBtn.snp_width)
        
    }
        
    likeBtn.snp_makeConstraints { (make) -> Void in
        make.left.equalTo(commentBtn.snp_right)
      // 1,三等分视图的第一步 两边的视图首先要贴边对齐
        make.right.equalTo(self.snp_right)
      // 2,视图三等分第二部 所有视图宽度相等
        make.width.equalTo(commentBtn.snp_width)
        make.top.bottom.equalTo(self)
        
   }
        
        
   let sepeView1 = sepeView()
        
   let sepeView2 = sepeView()
        
        let w:CGFloat = 0.5
        let scale = 0.4
     // 添加分割线
        addSubview(sepeView1)
        addSubview(sepeView2)
            
        
// 设置分割线的约束
  sepeView1.snp_makeConstraints { (make) -> Void in
    
   make.left.equalTo(retweetedBtn.snp_right)
    make.height.equalTo(self.snp_height).multipliedBy(scale)
    make.centerY.equalTo(self.snp_centerY)
    make.width.equalTo(w)
   
    
   }
    
        
        sepeView2.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(commentBtn.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(w)
            
            
        }
     }
    
 // 生成分割视图
    private func sepeView() ->UIView {
      
      let v = UIView()
    // 设置背景颜色
     v.backgroundColor = UIColor.darkGrayColor()
        
      return v
        
  }
    
    
    
    
 // MARK :懒加载所有子视图
 // 转发的按钮
    
    private lazy var retweetedBtn:UIButton = UIButton(title: "转发", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_retweet")
    
    private lazy var  commentBtn:UIButton = UIButton(title: "评论", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_comment")
    
    private lazy var  likeBtn:UIButton = UIButton(title: "喜欢", backImageName: nil, fontSize: 10, color: UIColor.darkGrayColor(), imageName: "timeline_icon_unlike")
    
   
}
