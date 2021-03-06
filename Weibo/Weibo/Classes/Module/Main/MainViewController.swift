//
//  MainViewController.swift
//  Weibo
//
//  Created by apple on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
// 必选属性
    let mainTabBar  = MaintabBar()
 // composeBtn 的点击方法
 @objc   private func composeBtnDidClick() {
        
        print(__FUNCTION__)
        
  }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        print(tabBar.classForCoder)
        
        
        mainTabBar.composeBtn.addTarget(self, action: "composeBtnDidClick", forControlEvents:.TouchUpInside)
        
        setValue(mainTabBar, forKey: "tabBar")
        
//        print(tabBar.classForCoder)
        
        // 添加子视图控制器
        
        addChildViewControllers()
    }

    // private 表示只能在本类访问
    private func addChildViewControllers() {
        
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
        
        
        
    }
    
         
    private func addChildViewController(vc:UIViewController,title:String,imageName:String) {
        
        self.tabBar.tintColor = UIColor.orangeColor()
        
        let nav = UINavigationController(rootViewController: vc)
        
        vc.title = title
        
        vc.tabBarItem.image = UIImage(named: imageName)
        
        self.addChildViewController(nav)
        
        
    }
  
    
      
}





















