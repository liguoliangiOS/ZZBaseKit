//
//  UIButton+Extension.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /**设置标题点击**/
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, target:Any , action:Selector) -> Self {
        let button = self.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.addTarget(target, action:action, for: .touchUpInside)
        return button
    }
    /**设置圆角和标题**/
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, cornerRadius:CGFloat, target:Any , action:Selector) -> Self {
        let button = zz_button(title: title, titleColor: titleColor, font: font, target: target, action: action)
        button.layer.masksToBounds = true
        button.layer.cornerRadius =  cornerRadius
        return button
    }
    /**设置背景颜色和标题**/
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, backgroundColor:UIColor, cornerRadius:CGFloat, target:Any , action:Selector) -> Self {
        
        let button = zz_button(title: title, titleColor: titleColor, font: font ,cornerRadius:cornerRadius, target:target, action:action)
        button.backgroundColor = backgroundColor
        return button
    }
    /**设置背景图片和标题**/
     class func zz_button(title:String, titleColor:UIColor, font:UIFont, backgroundImage:String, target:Any , action:Selector) -> Self {
        let button = zz_button(title: title, titleColor: titleColor, font: font, target: target, action: action)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
        return button
    }
    
    /**设置背景图片**/
    class func zz_button(backgroundImage:String, target:Any , action:Selector) -> UIButton {
        let button = self.init(type: .custom)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    /**设置背景图片**/
    class func zz_button(normalBackgroundImage:String, selectBackgroundImage:String, target:Any , action:Selector) -> UIButton {
        let button = self.init(type: .custom)
        button.setBackgroundImage(UIImage(named: normalBackgroundImage), for: .normal)
        button.setBackgroundImage(UIImage(named: normalBackgroundImage), for: .highlighted)
        button.setBackgroundImage(UIImage(named: selectBackgroundImage), for: .selected)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    /**设置图片**/
    class func zz_button(image:String, target:Any , action:Selector) -> UIButton {
        let button = self.init(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.setImage(UIImage(named: image), for: .highlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    class func zz_button(normalImage:String, selectImage:String, target:Any , action:Selector) -> UIButton {
        let button = self.init(type: .custom)
        button.setImage(UIImage(named: normalImage), for: .normal)
        button.setImage(UIImage(named: normalImage), for: .highlighted)
        button.setImage(UIImage(named: selectImage), for: .selected)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    ///实例
    
    ///设置按钮不做点击
    func zz_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, imageName: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(UIImage(named: imageName), for: .normal)
    }
    
    ///设置按钮
   func zz_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ target:Any , _ action:Selector) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.addTarget(target, action:action, for: .touchUpInside)
    }
    
    ///设置背景图片
    func zz_button(_ backgroundImage:String, _ target:Any ,_ action:Selector)  {
        self.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        self.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func zz_button(_ normalBackgroundImage:String, _ selectBackgroundImage:String, _ target:Any ,_ action:Selector)  {
        self.setBackgroundImage(UIImage(named: normalBackgroundImage), for: .normal)
        self.setBackgroundImage(UIImage(named: normalBackgroundImage), for: .highlighted)
        self.setBackgroundImage(UIImage(named: selectBackgroundImage), for: .selected)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    ///设置背景图片
    func zz_buttonImage(_ image:String, _ target:Any ,_ action:Selector)  {
        self.setImage(UIImage(named: image), for: .normal)
        self.setImage(UIImage(named: image), for: .highlighted)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func zz_buttonImage(_ normalImage:String, _ selectImage:String, _ target:Any ,_ action:Selector)  {
        self.setImage(UIImage(named: normalImage), for: .normal)
        self.setImage(UIImage(named: normalImage), for: .highlighted)
        self.setImage(UIImage(named: selectImage), for: .selected)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    ///设置背景图片和标题
    func zz_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ backgroundImage:String, _ target:Any , _ action:Selector) {
        zz_button( title, titleColor, font, target, action)
        self.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        self.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
    }
    
    ///设置圆角和标题
    func zz_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ cornerRadius:CGFloat, _ target:Any , _ action:Selector) {
        zz_button( title, titleColor, font, target, action)
        self.layer.masksToBounds = true
        self.layer.cornerRadius =  cornerRadius
    }
    
    ///设置背景颜色和标题
    func zz_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ backgroundColor:UIColor, _ cornerRadius:CGFloat, _ target:Any , _ action:Selector)  {
        zz_button( title, titleColor, font, cornerRadius, target, action)
        self.backgroundColor = backgroundColor
    }
}

public extension UIButton {
    
    func zz_buttonImageLabelPosition(_ position: UIView.ContentMode, _ spacing: CGFloat) {
        let title = self.titleLabel!.text!
        let imageSize = self.imageView!.image!.size
        let titleFont = self.titleLabel!.font
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont as Any])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
