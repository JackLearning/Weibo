//
//  AppDelegate.swift
//  Weibo
//
//  Created by apple on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 程序一启动就调这个方法
        let account = UserAccount.loadAccount()
          print("-------------")
          print("\(account) 哈哈哈哈哈哈哈哈哈哈哈哈")
        
        
        
//        let result = isNewVersion()
//        print(result)
        
        window = UIWindow(frame: UIScreen .mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        
        
        // 设置主题颜色
        setThemeColor()
        
        // 注册通知
        registerNotification()
        
        
        
        // 设置根控制器
        window?.rootViewController = defaultViewController()
        
        return true
        
    }
    
    // 注册通知
    private func registerNotification() {
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"SwitchRootVC:", name: change, object: nil)
        
    }
    
    // 移除通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // 通知的响应方法
   @objc private func SwitchRootVC(n:NSNotification) {
        
        print(n)
    // 根据通知去切换对应的根视图控制器
        if n.object != nil {
            // 跳转到welcome
            window?.rootViewController = WelcomeViewController()
            
            return
            
        }
        
       // 首页
        window?.rootViewController = MainViewController()
        
    }
    
    
   // 根据用户的是否登录显示具体的页面
      private func defaultViewController() ->UIViewController {
        
        if isNewVersion() {
            return NewFeatureViewController()
        }
        return WelcomeViewController()
        
    }
    

    // MARK :判断是否有新版本
    
    private func isNewVersion() -> Bool {
       
        // 获取当前应用的版本号
        let info = NSBundle.mainBundle().infoDictionary
        
        let currentStr = info!["CFBundleShortVersionString"] as! String
        
        let currentNum = Double(currentStr)
        
      print(currentNum)
        // 获取本地缓存的版本号
        // 用偏好设置来缓存版本
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let sandBoxKey = "sandBoxKey"
        let lastNum = userDefaults.doubleForKey(sandBoxKey)
        print(lastNum)
        // 立即存储 当前的版本号
        userDefaults.setDouble(currentNum!, forKey: sandBoxKey)
        userDefaults.synchronize()
        
        // 比较当前版本号 和 老版本号
        return currentNum! > lastNum
        
        
        
    }
    
    
    
    private func setThemeColor() {
        
        //一定要设置的,不如早设置
        UINavigationBar.appearance().tintColor = themeColor
        UITabBar.appearance().tintColor = themeColor
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

