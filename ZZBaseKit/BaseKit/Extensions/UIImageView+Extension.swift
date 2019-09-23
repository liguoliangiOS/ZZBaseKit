//
//  UIImageView+Extension.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

public extension UIImageView {
    
    /** 设置image **/
    class func zz_imagView(imageName:String) -> Self {
        let imageView = self.init()
        if imageName.count > 0 {
            imageView.image = UIImage(named: imageName)
        }
        return imageView
    }
    
    /** 创建imageView 有圆角 **/
    class func zz_imagView(imageName:String, cornerRadius:CGFloat) -> Self {
        let imageView = zz_imagView(imageName: imageName)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        return imageView
    }
    
    
    /// --- 实例方法
    /** 设置image **/
    func zz_imagView(_ imageName:String)  {
        self.image = UIImage(named: imageName)
    }
    
    /** 创建imageView 有圆角 **/
    func zz_imagView(_ imageName:String, _ cornerRadius:CGFloat)  {
        zz_imagView(imageName)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}

