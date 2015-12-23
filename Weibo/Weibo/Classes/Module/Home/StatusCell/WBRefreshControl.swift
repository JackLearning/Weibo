//
//  WBRefreshControl.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SnapKit


enum WBRefreshStatus:Int {
// 默认状态
   case Normal = 0
// 用户下拉到临界值 还没有松手刷新的状态
    case Pulling = 1
// 正在刷新的状态
    case Refreshing = 2

 

}
 // 刷新控件的高度
private let RefreshViewHeight: CGFloat = 60


class WBRefreshControl: UIControl {
    
    //定义属性 保存上一次刷新的状态
    var oldStatus:WBRefreshStatus  = .Normal
    
   //MARK:定义外部模型属性
    
    var status: WBRefreshStatus = .Normal  {
    didSet {
      // 根据不同的状态 更改显示的逻辑
    switch status {
    case .Pulling :
        print("准备起飞")
        //1,修改提示文案
        tipLabel.text = "准备起飞"
        //2,旋转箭头
       UIView.animateWithDuration(0.25, animations: { () -> Void in
        
           self.arrowIcon.transform = CGAffineTransformMakeRotation(
            CGFloat(M_PI))
        
       })
        
        
    case .Refreshing:
        print("正在起飞")
        tipLabel.text = "正在起飞"
        // 隐藏箭头 显示转动的小菊花
        arrowIcon.hidden = true
        loadIcon.startAnimating()
        
    // 应该主动触发 control 方法的响应事件
    // 修改contentInset
        var inset = scrollView!.contentInset
        inset.top += RefreshViewHeight
        scrollView?.contentInset = inset
        sendActionsForControlEvents(.ValueChanged)
        
        sendActionsForControlEvents(.ValueChanged)
    case .Normal:
        // 回到从前 最初的状态 重置
      print("下拉起飞")
        tipLabel.text = "下拉起飞"
        arrowIcon.hidden = false
        loadIcon.stopAnimating()
        
       // 修改contentInset inset.Top 会被多减一次
      if oldStatus == .Refreshing {
        
        var inset = scrollView!.contentInset
        inset.top -= RefreshViewHeight
        scrollView?.contentInset = inset
        
    }
        
        // 重置箭头方向
        UIView.animateWithDuration(0.25, animations: { () -> Void in
             self.arrowIcon.transform = CGAffineTransformIdentity
        })
        
       }
    // 所有的设置结束后 保存上一次的刷新状态
        oldStatus = status
        
    }
    
  }
    
  // 实现kvo方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        // 1,获取tableView的临界值
        let insetTop = scrollView?.contentInset.top ?? 0
        let condationValue = -(RefreshViewHeight + insetTop)
        // 2,获取tableView的contentOffset
        let offsetY = scrollView?.contentOffset.y ?? 0
        
        if scrollView!.dragging {
            if status == .Normal && offsetY < condationValue {
                // 用户下拉到临界值 还没松手刷新的状态
                status = .Pulling
                
            } else if status == .Pulling && offsetY > condationValue {
                
                // 进入默认状态
                status = .Normal
                
            }
        } else {
            
            // 不是在拉拽的状态 并且当前视图的status 是pulling状态 再执行刷新操作
            if status == .Pulling {
               status = .Refreshing
            }
    }
        
     // 3,比较对应的临界值和位移的大小
        
  }
    
 
    func endRefreshing() {
     
        status = .Normal
    }
    
   
   // view的生命周期方法
   // 子视图将要添加到父视图的时候
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview)
        // 可以获取到当前空间的父视图
        //  1,获取tableView 
        if let myFather = newSuperview as? UIScrollView {
            // 如果父视图能够转化为 滚动视图
            // 观察 滚动视图的contentOffset
            self.scrollView = myFather
            // 设置kvo
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
            
        }
        
    }
    
    // 移除kvo 观察
    deinit {
        
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
   // 定义属性 记录父视图
    var scrollView :UIScrollView?
    
   // MARK:重写构造方法
    override init(frame: CGRect) {
         // 在视图内部确定frame
        let rect = CGRect(x: 0, y: -RefreshViewHeight, width: screenW, height: RefreshViewHeight)
        super.init(frame: rect)
        
        setupUI()
        
        //设置颜色
        backgroundColor = UIColor.randomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // 设置页面和布局
    private func setupUI() {
        
      // 添加子视图
        addSubview(tipLabel)
        addSubview(arrowIcon)
        addSubview(loadIcon)
        
    // 设置约束
        tipLabel.snp_makeConstraints { (make) -> Void in
             make.centerX.equalTo(self.snp_centerX).offset(15)
             make.centerY.equalTo(self.snp_centerY)
        }
        
         arrowIcon.snp_makeConstraints { (make) -> Void in
             make.right.equalTo(tipLabel.snp_left).offset(-5)
            make.centerY.equalTo(tipLabel.snp_centerY)
        }
        
         loadIcon.snp_makeConstraints { (make) -> Void in
             make.center.equalTo(arrowIcon)
        }
        
    }
    
    
   //MARK:懒加载所有的子视图
    private lazy var arrowIcon:UIImageView = UIImageView(image: UIImage(named:"tableview_pull_refresh"))
    
    private lazy var tipLabel:UILabel = UILabel(title: "下拉起飞", color: UIColor.randomColor(), fontSize: 14)
    
    private lazy var loadIcon :UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
}



 