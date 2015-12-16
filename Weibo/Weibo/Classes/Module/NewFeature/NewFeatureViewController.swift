//
//  NewFeatureViewController.swift
//  Weibo
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

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

        
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        // 测试代码
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.yellowColor()
        
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
