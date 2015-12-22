//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by apple on 15/12/13.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

private let HomeCellID = "HomeCellID"

 class HomeTableViewController: BaseTableViewController {
    
    private  lazy var statuses = [Status]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 判断用户是否登录
        
        // 未登录
        if !userLogin {
            visitorLoginView?.setupInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: nil)
            
            return
        }
        // 已登录
        
        prepareTableView()
        loadData()
    }
    
    private func prepareTableView() {
        
        // 注册cell
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier:  HomeCellID)
        
        // 修改tableView的固定高度
//        tableView.rowHeight = 100
        // 自动计算cell的行高
        
        
        //1.设置预估行高  尽量的接近真实的行高 能够提高效率
        //tabelView能够自动计算行高 关键条件之一 就是 contentView必须添加约束
        // 1,给一个预估行高
        // 2,自动计算行高 注意cell 中各个小部件的位置要约束好，cell上部，和下部
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // 取消分割线
        tableView.separatorStyle = .None
        
        
    }
    
        
    // 第三方框架的简单使用
    
    private func  loadData() {
        // 实现网络请求
        let AFN = AFHTTPSessionManager()
        
        // get请求
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        // 判断token是否为空
        guard let token = UserAccountViewModel().token else {
            
            print("token为空")
            SVProgressHUD.showInfoWithStatus("请重新登录")
            return
        }
        
        let parameters = ["access_token" : token]
        
        AFN.GET(urlString, parameters: parameters, progress: { (p) -> Void in
            print(p)
            }, success: { (task, result) -> Void in
                // 在success回调中 做数据解析 需要判断result 能否转化为字典
                guard let dict = result as? [String:AnyObject] else {
                    
                    print("数据不合法")
                    SVProgressHUD.showInfoWithStatus("您的网络出错，请稍后再试")
                    return
                    
                }
                // 获取数据成功
                // 通过键值的方式 获取statuses对应的数组
                if let array  = dict["statuses"] as? [[String:AnyObject]] {
                    
                   print(array)
                    
                    // 遍历数组中的所有字典，完成字典转模型
                    var list = [Status]()
                    for item in array {
                        
                        let s = Status(dict: item)
                        // print(s)
                        list.append(s)
                  }
                    self.statuses = list
                    // 刷新表视图
                    self.tableView.reloadData()
                }
                
            }) { (task, error) -> Void in
                print(error)
        }
      }
  }

////MARK: tableView 数据源的协议方法
extension HomeTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //iOS 6.0 推出的方法  一定可以获取一个cell对象
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellID, forIndexPath: indexPath) as! StatusCell
        
        // cell.textLabel?.text = statuses[indexPath.row].user?.name
        
        cell.status = statuses[indexPath.row]
        
       print(statuses[indexPath.row].imageURLs!.count)
        
        
        return cell
    }
    
  }
