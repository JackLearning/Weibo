//
//  WelcomeViewController.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

import  UIKit


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
    
    
    
    private func setupUI() {
       
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        // 设置约束
        iconView.snp_makeConstraints { (make) -> Void in
             make.centerX.equalTo(view.snp_centerX)
             make.bottom.equalTo(view.snp_bottom).offset(-200)
            
        }
        
       welcomeLabel.snp_makeConstraints { (make) -> Void in
        
        make.centerX.equalTo(iconView.snp_centerX)
        make.top.equalTo(iconView.snp_bottom).offset(16)
        
        }
     
        
        
    }
    
    
    
    
 // MARK 懒加载所有的子视图
    private lazy var backImageView:UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named:"avatar_default_big"))
    
    
    // 可选项不能直接进行计算
    
    private lazy var welcomeLabel:UILabel = {
        
        let l = UILabel()
        
        l.text = UserAccountViewModel().userName ?? "" + "欢迎归来"
        l.font = UIFont.systemFontOfSize(16)
        l.textColor = UIColor.lightGrayColor()
        
        l.sizeToFit()
        
        
        return l
        
    }()
    
}











