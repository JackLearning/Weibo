//
//  BaseTableViewController.swift
//  Weibo
//
//  Created by apple on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

// 遵守协议,并且实现代理方法,否则会报错
class BaseTableViewController: UITableViewController,VisitorLoginViewDelegate{

   // 设置用户是否登录的标记
    var userLogin = UserAccountViewModel().userLogin
    
    // 新建访客视图的属性
    var visitorLoginView:VisitorLoginView?
    
    //加油子视图  准备所有的视图层次关系
    //苹果专门为手码开发准备的 一旦实现了该方法  xib/ sb 自动失效
    //如果检测到view(根视图)为 nil  会自动调用 loadView
    
    override func loadView() {
        
        if userLogin {
            // 如果用户登录了就正常显示,否则就显示访客视图
            
            super.loadView()
        }else {
            
            setVisitorLoginView()
        }
        
    }
        
       // 自定义的访客视图
        private func  setVisitorLoginView(){
            
//            let v = VisitorLoginView()
//            view = v
            
            visitorLoginView = VisitorLoginView()
            // 设置当前类为代理,替VisitorLoginView 干活,并把处理的结果返回给VisitorLoginView
            
            visitorLoginView?.visitorViewDelegate = self
            
            view = visitorLoginView
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "userWillLogin")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "userWillRegister")
            
        }
        
    
    // 实现代理方法
    func userWillLogin() {
        print(__FUNCTION__)
        
   let oauth = OAuthViewController()
        // 添加到导航视图控制器上
        let nav = UINavigationController(rootViewController: oauth)
        presentViewController(nav, animated: true, completion: nil)
        
               
        
        
    }
    func userWillRegister() {
         print(__FUNCTION__)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(view.bounds)
        
    }

    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        
        //print(view.bounds)
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
