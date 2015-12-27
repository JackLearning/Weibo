//
//  OAuthViewController.swift
//  Weibo
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

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
       //  print(view.classForCoder)
        loadOAuthPage()
        setNavBar()
    }
  // MARK :加载授权页面
    private func loadOAuthPage() {
        // 1,urlString
        
//        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        
        
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
//         print(request.URL)
        
      // 根据我们的需求,去屏蔽一些url
        guard let urlString = request.URL?.absoluteString else {
           return false
      }
        
        if urlString.hasPrefix("https://api.weibo.com/") {
            
            // 有这个前缀的是我们希望加载的页面
            return true
            
        }
        if !urlString.hasPrefix("http://www.baidu.com") {
            
            //一定不是请求成功的回调,不希望加载
            return  false
            
        }
        
       // 程序走到这里,我们已经屏蔽了我们不需要的回调
        // print(urlString)
        
        // 解析字符串的code码
        // query 获取url 中参数部分
        let query = request.URL?.query
        
        if let q = query {
            // 字符串的截取操作
            let codeStr = "code="
            let code = q.substringFromIndex(codeStr.endIndex)
            
            //print(code)
           loadAccessToken(code)
            
        }
        
        
        return true
    }
    
 // MARK: 加载用户token(请求标识)
    private func loadAccessToken(code: String) {
        
        UserAccountViewModel().loadAccessToken(code) { (isSuccess) -> () in
            if isSuccess {
                print("登录成功")
                self.close()
          }else {
                
                print("登录失败")
            }
        }
        
    }
    
//    //MARK :获取用户信息
//    private func loadUserInfo(token: String,uid:String) {
//        
//      let urlString = "https://api.weibo.com/2/users/show.json"
//      let parameters = ["access_token":token,"uid":uid]
//        let AFN = AFHTTPSessionManager()
//        
//        AFN.GET(urlString, parameters: parameters, progress: { (p) -> Void in
//            
//            }, success: { (_, result) -> Void in
//                
//                print(result)
//                if let dict = result {
//                    if let dict = result {
//                        
//                        let avatar_large = dict["avatar_large"] as! String
//                        let name = dict["name"] as! String
//                       
//                        print(avatar_large,name)
//                        
//                    }
//                    
//                    
//                  print(dict)
//                    
//                    
//                }
//                
//            }) { (_, error) -> Void in
//                print(error)
//        }
//        
//        
//        
//        
//        
//    }
//    
    
    
    
    
    
    
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


























