//
//  StatusCellTopView.swift
//  Weibo
//
//  Created by ZhuZongchao on 15/12/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import SDWebImage


class StatusCellTopView: UIView {
    
    // 定义微博模型属性
    var status: Status? {
        didSet {
    // 绑定数据
     iconImage.sd_setImageWithURL(status?.user?.headURL)
     nameLabel.text = status?.user?.name
     mbrankImage.image = status?.user?.mbrankImage
    verified_type_image.image = status?.user?.verified_type_image
     //TODO: 后续完善
     timeLabel.text = status?.created_at
     sourceLabel.text = status?.source
    contentLabel.text = status?.text
            
            
        }
        
    }
    
    
    
    

    override init(frame: CGRect) {
         super.init(frame: frame)
        // 设置背景颜色 调试用
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        setupUI()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      
    // 添加子视图
        addSubview(iconImage)
        addSubview(nameLabel)
        addSubview(mbrankImage)
        addSubview(verified_type_image)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        addSubview(pictureView)
        
        
     // 设置约束
     iconImage.snp_makeConstraints { (make) -> Void in
        make.left.equalTo(self.snp_left).offset(StatusCellMarigin)
        make.top.equalTo(self.snp_top).offset(StatusCellMarigin)
        make.size.equalTo(CGSize(width: StatusCellHeadImageWidth, height: StatusCellHeadImageWidth))
        }
      
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(iconImage.snp_top)
            make.left.equalTo(iconImage.snp_right).offset(StatusCellMarigin)
            
        }
        
        
       mbrankImage.snp_makeConstraints { (make) -> Void in
        
        make.top.equalTo(nameLabel.snp_top)
        make.left.equalTo(nameLabel.snp_right).offset(StatusCellMarigin)
        
        
        }
        
        verified_type_image.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(iconImage.snp_right)
            make.centerY.equalTo(iconImage.snp_bottom)
            
        }
        
        
       timeLabel.snp_makeConstraints { (make) -> Void in
        
        make.bottom.equalTo(iconImage.snp_bottom)
        make.left.equalTo(iconImage.snp_right).offset(StatusCellMarigin)
        
        }
        
        
        sourceLabel.snp_makeConstraints { (make) -> Void in
             make.bottom.equalTo(timeLabel.snp_bottom)
            make.left.equalTo(timeLabel.snp_right).offset(StatusCellMarigin)
        }
        
       contentLabel.snp_makeConstraints { (make) -> Void in
         make.top.equalTo(iconImage.snp_bottom).offset(StatusCellMarigin)
         make.left.equalTo(self.snp_left).offset(StatusCellMarigin)
        
   }
        
        // 对配图视图的约束
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMarigin)
            make.left.equalTo(contentLabel.snp_left)
            make.size.equalTo(CGSize(width: 100, height: 100))
 
        }
        
        
     // 对顶部视图的底部进行约束
        self.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(pictureView.snp_bottom).offset(StatusCellMarigin)
        }
        
        
    }
         
  // 懒加载所有的子视图
    private lazy var iconImage:UIImageView = UIImageView(image: UIImage(named:"avatar_default_big"))
 
    private lazy var nameLabel:UILabel = UILabel(title: "哈哈哈", color: themeColor, fontSize: 14)
    
    private lazy var mbrankImage:UIImageView = UIImageView(image: UIImage(named:"common_icon_membership"))
    
    private lazy var
    verified_type_image: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    private lazy var timeLabel:UILabel = UILabel(title: "11.11", color: themeColor, fontSize: 10)
    private lazy var sourceLabel:UILabel = UILabel(title: "啊你", color: themeColor, fontSize: 10)
    private lazy var contentLabel: UILabel = UILabel(title: "咸鱼翻身啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊鹅鹅鹅鹅鹅鹅饿鹅鹅鹅", color: UIColor.darkGrayColor(), fontSize: 14, margin:StatusCellMarigin )
    
    // 配图视图
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    
    
    
    
    
}


