//
//  VisitorLoginView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit


// 定义协议
@objc protocol VisitorLoginViewDelegate:NSObjectProtocol {
    
    // 声明协议方法
    // 用户将要登录
    optional func userWillLogin()
    //用户将要注册
    func userWillRegister()
    
    
}




class VisitorLoginView: UIView {
    
    // 定义代理属性
    // 同样要用weak,swift默认都是strong
    weak var visitorViewDelegate: VisitorLoginViewDelegate?
    
    
    
   // 对外提供设置访客视图信息的方法
    func setupInfo(tipText:String,imageName:String?) {
        tipLabel.text = tipText
        if let name = imageName {
            
            //不是首页
            circleView.image = UIImage(named: name)
            // 隐藏大房子
            largeIcon.hidden = true
            // 将circleView移动到视图的最顶层
            bringSubviewToFront(circleView)
        }else {
            // 是首页
            // 做动画
            startAnimation()
            
            
        }
    
        
    }
   
    private func startAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        anim.repeatCount = MAXFLOAT
        anim.duration = 20.0
        anim.toValue = 2*M_PI
        //当动画完毕或者页面失去活跃状态动画不移除图层
        anim.removedOnCompletion  = false
        // 添加动画
        circleView.layer.addAnimation(anim, forKey: nil)
        
        
    }
    
    
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
        
        
         addSubview(backView)
        
        
        addSubview(largeIcon)
        addSubview(circleView)
        addSubview(tipLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        //使用自动布局
        //NSLayoutConstraint  VFL
        /**
        *  返回一个自动布局约束对象
        *
        *  @param item         需要添加约束的对象
        *  @param attribute   添加约束的对象的需要约束的属性description#>
        *  @param relatedBy 约束的关系  一般使用 equal 表示精准约束
        *  @param toItem    相对约束的对象 description#>
        *  @param attribute 相对约束的兑现的属性
        *  @param multiplier           乘积值  一般 1
        *  @param constant           约束值
        *
        *   view1.attr1 = view2.attr2 * multiplier + constant
        自动布局原则 : 先固定好一个视图  其他所有视图 都应该相对于一个已经固定好的视图添加约束
        */
        //约束需要添加到父视图
        //在使用手码添加约束 需要屏蔽 frame布局
        //        largeIcon.translatesAutoresizingMaskIntoConstraints = false
        //        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        for subView in subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -60))
        
        //添加圆圈的约束
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterX, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .CenterX, relatedBy: .Equal, toItem: circleView, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Top, relatedBy: .Equal, toItem: circleView, attribute: .Bottom, multiplier: 1, constant: 16))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 230))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40))
        
        //按钮的约束
        
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Left, relatedBy: .Equal, toItem: tipLabel, attribute: .Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Right, relatedBy: .Equal, toItem: tipLabel, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        
      
        
        
    
    
    //设置背景视图的约束 可视化的布局语言
    //OC 中可选项 一般使用 按位 或枚举选项  swift中直接指定数组
    //metrics:约束数值字典 [String: 数值],
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backView]-0-|", options: [], metrics: nil, views: ["backView": backView]))
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backView]-(-35)-[regBtn]", options: [], metrics: nil, views: ["backView": backView,"regBtn":registerBtn]))
        
        
        
        
          backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        // 添加点击事件
        registerBtn.addTarget(self, action: "registerBtnDidClick", forControlEvents: .TouchUpInside)
        loginBtn.addTarget(self, action: "loginBtnDidClcik", forControlEvents:.TouchUpInside)
        
        
        
    
    }
    
    //MARK:按钮的监听事件
    @objc private func registerBtnDidClick() {
        
         // 代理调用协议方法,如果为nil 就不会执行该方法
        visitorViewDelegate?.userWillRegister()
    }
    
    @objc private func loginBtnDidClcik() {
        
        //判断代理是否为空 && 是否响应方法  userWillLogin? 表示的是判断是否可以响应方法
        
        visitorViewDelegate?.userWillLogin?()
        
    }
    
    
    
    
    //懒加载所有的子视图
   // 背景遮罩
    private lazy var backView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    private lazy var largeIcon: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var circleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var tipLabel: UILabel = {
        let l = UILabel()
        
        l.text = "关注一些人，回这里看看有什么惊喜,关注一些人，回这里看看有什么惊喜"
        l.textColor = UIColor.darkGrayColor()
        l.textAlignment = .Center
        l.font = UIFont.systemFontOfSize(14)
        l.numberOfLines = 0
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
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.sizeToFit()
        return btn
    }()
    
  
    

}
