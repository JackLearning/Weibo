//
//  OAuthViewController.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    
    let webView = UIWebView()
    
    @objc private func close() {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @objc private func defaultAccount() {
        
        let jsString = "document.getElementById('userId').value = 'leiggee@126.com',document.getElementById('passwd').value = 'oyonomg'"
        
        webView.stringByEvaluatingJavaScriptFromString(jsString)
        
        
    }
    
    
    
    
    
    
    
    
    override func loadView() {
         view = webView
        // 设置代理
        webView.delegate = self
        
        
        
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
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style:.Plain, target: self, action: "defaultAccount")
        
        
        
    }
    
    
    

   }
    
 // 扩展代码块
extension OAuthViewController:UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        SVProgressHUD.show()
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
         SVProgressHUD.dismiss()
    }
    
    //协议方法 返回值为bool  一般返回true就可以正常工作

    // 屏蔽掉那些我们不希望加载的页面,只加载我们想要加载的页面
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
         print(request.URL)
        
        return true
    }
    
    
    
    
    
    
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


























