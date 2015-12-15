//
//  OAuthViewController.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
 

class OAuthViewController: UIViewController {
    
    
    let webView = UIWebView()
    
    @objc private func close() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func loadView() {
         view = webView
    }
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        print(view.classForCoder)
        loadOAuthPage()
        setNavBar()
    }
  // MARK :加载授权页面
    private func loadOAuthPage() {
        // 1,urlString
        
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        
        let url = NSURL(string: urlString)
        //程序员承诺有值
        webView.loadRequest(NSURLRequest(URL: url!))
        
        
        
    }
    
    
   // MARK:设置导航条
    private func setNavBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

   }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


























