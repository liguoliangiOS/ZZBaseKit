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
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, target:Any , action:Selector) -> UIButton {
        
        let button:UIButton = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.addTarget(target, action:action, for: .touchUpInside)
        return button
    }
    /**设置圆角和标题**/
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, cornerRadius:CGFloat, target:Any , action:Selector) -> UIButton {
        let button:UIButton = UIButton.zz_button(title: title, titleColor: titleColor, font: font, target: target, action: action)
        button.layer.masksToBounds = true
        button.layer.cornerRadius =  cornerRadius
        return button
    }
    /**设置背景颜色和标题**/
    class func zz_button(title:String, titleColor:UIColor, font:UIFont, backgroundColor:UIColor, cornerRadius:CGFloat, target:Any , action:Selector) -> UIButton {
        
        
        let button:UIButton = UIButton.zz_button(title: title, titleColor: titleColor, font: font ,cornerRadius:cornerRadius, target:target, action:action)
        button.backgroundColor = backgroundColor
        return button
    }
    /**设置背景图片和标题**/
     class func zz_button(title:String, titleColor:UIColor, font:UIFont, backgroundImage:String, target:Any , action:Selector) -> UIButton {
        let button:UIButton = UIButton.zz_button(title: title, titleColor: titleColor, font: font, target: target, action: action)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
        return button
    }
    
    /**设置背景图片**/
    class func zz_button(backgroundImage:String, target:Any , action:Selector) -> UIButton {
        let button:UIButton = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        button.setBackgroundImage(UIImage(named: backgroundImage), for: .highlighted)
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
    
    ///设置背景图片
    func zz_buttonImage(_ image:String, _ target:Any ,_ action:Selector)  {
        self.setImage(UIImage(named: image), for: .normal)
        self.setImage(UIImage(named: image), for: .highlighted)
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
