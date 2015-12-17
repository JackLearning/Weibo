//
//  NewFeatureViewController.swift
//  Weibo
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SnapKit

private let  imageCount = 4

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {

    // 重载,自己写一个初始化方法
    
    init() {
        
        // 使用collectionCell一定要指定布局
        let layout = UICollectionViewFlowLayout()
        // 修改布局
        layout.itemSize = UIScreen.mainScreen().bounds.size
        // 修改视图的滚动方向(默认是垂直方向滚动的)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        // 设置item上下左右的间距
        layout.minimumInteritemSpacing = 0 // 左右间距
        layout.minimumLineSpacing = 0 // 行间距
        
        super.init(collectionViewLayout:layout)
        // super init 是构造的最后一步
        // 分页
        collectionView?.pagingEnabled = true
        //取消水平方向的滚动指示器
        collectionView?.showsHorizontalScrollIndicator = false
        // 取消弹簧效果
        collectionView?.bounces = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
      
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // cell 的真实身份是NewFeatureCell
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)as! NewFeatureCell
       
        cell.index = indexPath.item
        
    
        return cell
        
    }
    
    
    // 等cell 完全展示完后，在实现动画
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        //cell完成展示之后  indexPath 对应的是 上一个cell indexPath 不能使用 indexPath 来获取cell
        print(indexPath.item)
        // 获取准确的cell
        let cell  = collectionView.visibleCells().last! as! NewFeatureCell
        
        // 获取cell indexpath
        let index = collectionView.indexPathForCell(cell)!
        
         //判断index.item是不是等于 3  执行动画
        if index.item == imageCount - 1 {
            // 执行动画
            cell.showAnimation()
            
        }
        
    }
    
}


// 在一个文件中 可以建多个类
class NewFeatureCell: UICollectionViewCell {
    
    // 添加index 属性
    var index: Int = 0 {
        didSet {
            
           // didSet 和OC中重写set方法一样
            
           iconView.image = UIImage(named: "new_feature_\(index + 1)")
            
            // 隐藏开始按钮
            startBtn.hidden = true
        }
        
    }
    
    
    private func showAnimation() {
        
        // 在动画开始前，修改transform
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        
        startBtn.hidden = false
        
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            
            self.startBtn.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                print("OK")
        }
        
        
    }
   
    
    
    // 重写构造方法 cell构造的入口
    override init(frame: CGRect) {
         super.init(frame: frame)
        print(frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func  startBtnClick () {
    
    print(__FUNCTION__)
    
    
    }
    
    
    
    
    
    
    
   // 设置界面
    private func setupUI() {
        
      // 添加子视图
      // 自定义的子视图 要添加到contentView 上
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        
        // 使用SnapKit添加约束
        iconView.snp_makeConstraints { (make) -> Void in
             // make 表示需要添加约束的对象
            make.edges.equalTo(contentView.snp_edges)
        }
        
       // 设置开始按钮的约束
        startBtn.snp_makeConstraints { (make) -> Void in
             make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView.snp_bottom).offset(-180)
            
            
            
        }
       // 添加按钮的点击事件
        
        startBtn.addTarget(self, action: "startBtnClick", forControlEvents: .TouchUpInside)
    }
    
    
    
    
  // 分析所有视图，将所有的子视图懒加载
    
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    
    // 懒加载开始按钮
    private lazy var startBtn: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
        btn.setTitle("开始体验", forState:.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        // 设置大小
        btn.sizeToFit()
        
        return btn
        
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
























