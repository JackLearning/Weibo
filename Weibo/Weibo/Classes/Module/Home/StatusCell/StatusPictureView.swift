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
    // MARK:定义外部模型属性
    
    var imageURLs: [NSURL]? {
        didSet {
            //修改配图视图的大小
            let pSize = caclePictureViewSize()
            //更新配图视图的大小
            self.snp_updateConstraints { (make) -> Void in
                make.size.equalTo(pSize)
            }
            
            
            //修改测试的文案
            testLabel.text = "\(imageURLs?.count ?? 0)"
            
            // 刷新列表
            reloadData()
            
        }
    }
    
    // MARK:重写构造方法
    
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        //实例化一个 流水布局
        let flowLayout = UICollectionViewFlowLayout()
        // 设置间距
        flowLayout.minimumInteritemSpacing = pictureCellMargin
        flowLayout.minimumLineSpacing = pictureCellMargin
             
        super.init(frame: frame, collectionViewLayout: flowLayout)
        backgroundColor = UIColor.whiteColor()
        
        self.registerClass(PictureCell.self, forCellWithReuseIdentifier:pictureCellID)
        
        // 设置数据源
        self.dataSource = self
        
        
        //设置视图
        setupUI()
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
    
    //计算配图视图的大小
    private func caclePictureViewSize() -> CGSize {
        //计算配图的大小
        //1.获取配图的数量
        let imageCount = imageURLs?.count ?? 0
        //获取配图视图的最大宽度
        let maxWidth = screenW - 2 * StatusCellMarigin
        let itemWidth = (maxWidth - 2 * pictureCellMargin) / 3
        
        
        // 1,取出collectionView的流水布局
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 设置itemSize
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        
        //没有图片
        if imageCount == 0 {
            return CGSizeZero
        }
        //单张图片
        if imageCount == 1 {
            //TODO: 单图会按照图片等比例显示
            //先给定固定尺寸
            let imageSize = CGSize(width: 180, height: 120)
            // 设置单张图片的 itemSize
            layout.itemSize = imageSize
            return imageSize
        }
        
        if imageCount == 4 {
            //多图如果是4张，会按照 2 * 2 显示
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
        
        return CGSize(width: maxWidth, height: row * itemWidth + (row - 1) * pictureCellMargin )
    }
    
    // MARK:设置页面 和 布局
    private func setupUI() {
        self.addSubview(testLabel)
        testLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
        }
    }
    
    
    // MARK:懒加载所有的子视图
    private lazy var testLabel: UILabel = UILabel(title: "", color: UIColor.redColor(), fontSize: 30)
        

   }

// 数据源方法
//MARK: 数据源方法
extension StatusPictureView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //使用这个方法 一定要注册cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(pictureCellID, forIndexPath: indexPath) as! PictureCell
       //  cell.backgroundColor = UIColor.randomColor()
        
        cell.imageURL = imageURLs![indexPath.item]
        
        return cell
}

}

class PictureCell: UICollectionViewCell {
    // MARK:定义外部模型属性
    var imageURL: NSURL? {
        didSet {
            iconView.sd_setImageWithURL(imageURL)
        }
    }
    // MARK:重写构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:设置页面 和 布局
    private func setupUI() {
        contentView.addSubview(iconView)
        
        //设置布局
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(snp_edges)
        }
    }
    
    
    // MARK:懒加载所有的子视图
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        //ScaleAspectFill 显示图片的原比例 但是 图片会被裁减   一般采用这种方式
        //ScaleToFill  图片默认的显示样式  但是 图片 会被压缩 或者拉伸 一般不推荐使用这种方式来显示
        
        iv.contentMode = UIViewContentMode.ScaleAspectFill
        //在手码开发中 图片的默认的剪裁 是没有开启的  需要手动设置
        iv.clipsToBounds = true
        
        return iv
        }()
 
}

 