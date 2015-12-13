//
//  VisitorLoginView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit

class VisitorLoginView: UIView {
    
    override init(frame: CGRect) {
        //调用super.init
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //设置所有的子视图
    private func setupUI() {
        addSubview(largeIcon)
    }
    
    
    //懒加载所有的子视图
    private lazy var largeIcon: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var circleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var tipLabel: UILabel = {
        let l = UILabel()
        
        l.text = "关注一些人，回这里看看有什么惊喜,关注一些人，回这里看看有什么惊喜"
        l.textColor = UIColor.darkGrayColor()
        l.textAlignment = .Center
        l.font = UIFont.systemFontOfSize(14)
        l.sizeToFit()
        
        return l
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitle("注册", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(themeColor, forState: .Normal)
        btn.sizeToFit()
        return btn
    }()
    
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.setTitle("登录", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(themeColor, forState: .Normal)
        btn.sizeToFit()
        return btn
    }()
    
  
    
    

}
