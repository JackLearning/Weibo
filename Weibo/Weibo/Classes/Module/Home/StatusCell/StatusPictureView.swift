//
//  StatusPictureView.swift
//  Weibo
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

private let pictureCellID = "pictureCellID"
private let pictureCellMargin:CGFloat = 5

class StatusPictureView: UICollectionView {

    
    //MARK:定义外部模型属性
    
    var imageURLs:[NSURL]? {
        didSet {
      // 修改配图视图的大小
            let pSize = caclePictureViewSize()
       // 更新视图配图的大小
         self.snp_updateConstraints { (make) -> Void in
             make.size.equalTo(pSize)
            }
         // 修改测试的文案
            testLabel.text = "\( imageURLs?.count ?? 0)"
            
            // 刷新列表
            reloadData()
            
        }
              
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        // 实例化一个 流水布局
        let flowLayout = UICollectionViewFlowLayout()
        // 设置间距
        flowLayout.minimumInteritemSpacing = pictureCellMargin
        flowLayout.minimumLineSpacing = pictureCellMargin
        super.init(frame: frame, collectionViewLayout: flowLayout)
        backgroundColor = UIColor.whiteColor()
        
        // 注册cell
        self.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: pictureCellID)
                 
        //设置视图
        setupUI()
        // 设置数据源
        self.dataSource  = self
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    单图会按照图片等比例显示
    多图的图片大小固定
    多图如果是4张，会按照 2 * 2 显示
    多图其他数量，按照 3 * 3 九宫格显示
    */
  
    private func caclePictureViewSize() ->CGSize {
       // 计算配图的大小
       // 获取配图的数量
        
       let imageCount = imageURLs?.count ?? 0
        
      // 获取配图视图的最大宽度
        let maxWidth = screenW - 2 * StatusCellMarigin
        let itemWidth = (maxWidth - 2 * pictureCellMargin) / 3
        
     // 取出流水布局
        let layout  = self.collectionViewLayout as! UICollectionViewFlowLayout
     // 设置itemSize 
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // 没有图片
        if imageCount == 0 {
            
         return CGSizeZero
            
        }
        
       // 单张图片
        
        if imageCount == 1 {
          // 单图会按原比例显示
            let imageSize  = CGSize(width: 180, height: 120)
            return imageSize
            
        }
        
        if imageCount == 4 {
            
         // 4 张图片 会 2* 2 显示
         let w = itemWidth * 2 + pictureCellMargin
            return CGSize(width: w, height: w)
            
            
        }
        
        //如果程序走到这里 就是其他的多张图片
        //1. 确定有多少行
        /*
        1,2,3  -> 1
        4,5,6  -> 2
        7,8,9  -> 3
        先 整体 + 1  -> 修正 分子 -1
        */

        
   let row = CGFloat((imageCount - 1) / 3 + 1)
  
    return CGSize(width: maxWidth, height:  row * itemWidth + (row - 1) * pictureCellMargin)
        
 }
    
    
    //MARK:设置页面和布局
    private func setupUI() {
        
      self.addSubview(testLabel)
        testLabel.snp_makeConstraints { (make) -> Void in
             make.center.equalTo(self.snp_center)
        }
        
    }
 //懒加载所有子视图
    
    private lazy var testLabel:UILabel = UILabel(title: "", color: UIColor.redColor(), fontSize: 30)
    
    
}

// 数据源方法
extension StatusPictureView:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return imageURLs?.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         // 使用这个方法一定要注册cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(pictureCellID, forIndexPath: indexPath)
        
       cell.backgroundColor = UIColor.randomColor()
        
        return cell
        
        
    }
    
}
 

