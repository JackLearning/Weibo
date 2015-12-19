//
//  WelcomeViewController.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit
import SnapKit
import SDWebImage


class WelcomeViewController: UIViewController {
    
    
    override func loadView() {
         // 将跟视图 = 背景视图
        // 偷梁换柱
        view = backImageView
    }
   
    override func viewDidLoad() {
         super.viewDidLoad()
        setupUI()
    }
    
 // 执行动画 根视图没有设置frame
 // 一般在viewDidAppear方法中执行动画
    override func viewDidAppear(animated: Bool)
    {
         super.viewDidAppear(animated)
        print(view)
        showAnimation()
        
    }
    
 // 执行动画：修改iconView的底部约束
    
    private func showAnimation() {
        
     // 设置label 的透明度为0
     welcomeLabel.alpha = 0
     // 弹簧系数 * 10 ~= 加速度  这个时候动画效果一般不会太奇葩
        
       // 修改底部约束
        let offset = -UIScreen.mainScreen().bounds.height + 200
        iconView.snp_updateConstraints { (make) -> Void in
            
            make.bottom.equalTo(view.snp_bottom).offset(offset)
        }
        
        
         UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.98, initialSpringVelocity: 9.8, options: [], animations: { () -> Void in
            
              self.view.layoutIfNeeded()
            
            }) { (_) -> Void in
                
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.welcomeLabel.alpha = 1
                    
                    }, completion: { (_) -> Void in
                         print("OK")
                        
                        // 动画结束时,发出切换页面的通知
                        NSNotificationCenter.defaultCenter().postNotificationName(change, object: nil)
                        
                        
                        
                })
                
                
        }
        
        
    }
    
    
    
    private func setupUI() {
       
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        // 设置约束
        iconView.snp_makeConstraints { (make) -> Void in
             make.centerX.equalTo(view.snp_centerX)
             make.bottom.equalTo(view.snp_bottom).offset(-200)
             make.size.equalTo(CGSizeMake(90, 90))
            
        }
        
       welcomeLabel.snp_makeConstraints { (make) -> Void in
        
        make.centerX.equalTo(iconView.snp_centerX)
        make.top.equalTo(iconView.snp_bottom).offset(16)
        
        }
     
        // 设置iconView对应的图片
        
        iconView.sd_setImageWithURL(UserAccountViewModel().headURL, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 设置圆角图片
        iconView.layer.cornerRadius = 45
        // 裁剪
        iconView.layer.masksToBounds = true
        

        
    }
       
 // MARK 懒加载所有的子视图
    private lazy var backImageView:UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named:"avatar_default_big"))
    
    
    // 可选项不能直接进行计算
    
    private lazy var welcomeLabel:UILabel = UILabel(title:UserAccountViewModel().userName ?? "", color: UIColor.lightGrayColor(), fontSize: 16)

}