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
   // 添加自定义下拉刷新控件
    private lazy var refreshView:WBRefreshControl = WBRefreshControl()
    
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
        
        // 设置系统下拉刷新
        //refreshControl = UIRefreshControl()
        
        // 绑定事件
        //refreshControl?.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        
        // 设置tableView 的tableFooterView
        tableView.tableFooterView = indicatorView
        
        
        // 添加自定义下拉刷新控件
        tableView.addSubview(refreshView)
        refreshView.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        
        
    }
    
        
    // 第三方框架的简单使用
    
  @objc   private func  loadData() {
    
      //使用viewmodel获取网络数据
      //since_id 和 max_id 是互斥条件 有且只能传一个
    var max_id :Int64 = 0
    var since_id :Int64 = 0
    
    // 需要数据  小菊花是否正在转动 判断是否上拉加载更多
    if indicatorView.isAnimating() {
     
        // 上拉加载更多数据
        max_id = statuses.last?.id ?? 0
    }else {
        
        since_id = statuses.first?.id ?? 0
        
    }
    
 StatusListViewModel.loadHomePageData(since_id, max_id: max_id) { (statuses) -> () in
    
    // 网络加载结束 关闭动画
    self.refreshControl?.endRefreshing()
    
    guard let list = statuses else {
        return
    }
    
   // 测试打印
    print("---------------")
    print(list.count)
    if since_id > 0 {
        // 下拉刷新 新数据的操作 执行添加的操作
        self.statuses = list + self.statuses
    }else if max_id > 0{
        // 上拉加载更多数据
        self.statuses += list
        // 数据加载完毕之后 应该结束动画 不然只能加载一页数据
        self.indicatorView.stopAnimating()
        
    } else {
        // 首次加载
        self.statuses = list
        
    }
  // 执行刷新
    self.tableView.reloadData()
  
  }
    
 }
    
    // 懒加载小菊花
    private lazy var indicatorView:UIActivityIndicatorView = {
       let i = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        
        // 开始动画
//        i.startAnimating()
        return i
        
    }()
    
    
  }

////MARK: tableView 数据源的协议方法
extension HomeTableViewController {
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //iOS 6.0 推出的方法  一定可以获取一个cell对象
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellID, forIndexPath: indexPath) as! StatusCell
        
        // cell.textLabel?.text = statuses[indexPath.row].user?.name
        
        cell.status = statuses[indexPath.row]
        
       // print(statuses[indexPath.row].imageURLs!.count)
        
        if !indicatorView.isAnimating() && indexPath.row == statuses.count - 1 {
           // 滑动到最后一行 并且小菊花没有转动的情况下 自动加载数据
           // 在加载数据之前 转动小菊花
            indicatorView.startAnimating()
            loadData()
        }
        
        return cell
    }
    
  }
