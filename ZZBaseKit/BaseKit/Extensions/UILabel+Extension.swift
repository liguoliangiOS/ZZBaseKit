//
//  UILabel+Extension.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /** 快速创建 label **/
    class func zz_label(text:String, textColor:UIColor, font:UIFont) -> UILabel {
        let label:UILabel = UILabel.init()
        label.text = text
        label.textColor = textColor
        label.font = font
        return label
    }
    
    /** 创建 label 设置对齐方式 **/
    class func zz_label(text:String, textColor:UIColor, font:UIFont, textAlignment:NSTextAlignment) -> UILabel {
        let label:UILabel = zz_label(text: text, textColor: textColor, font: font)
        label.textAlignment = textAlignment
        return label
    }
    
    
    
    /** 创建 label 设置行数 **/
    class func zz_label(text:String, textColor:UIColor, font:UIFont, numberOfLines:NSInteger) -> UILabel {
        let label:UILabel = zz_label(text: text, textColor: textColor, font: font)
        label.numberOfLines = numberOfLines
        return label
    }
    
    
    
    /** 创建 label 设置背景色 **/
    class func zz_label(text:String, textColor:UIColor, font:UIFont, backgroundColor:UIColor) -> UILabel {
        let label:UILabel = zz_label(text: text, textColor: textColor, font: font)
        label.backgroundColor = backgroundColor
        return label
    }
    
    
    /** 创建 label 设置对齐方式 背景色 **/
    class func zz_label(text:String, textColor:UIColor, font:UIFont, backgroundColor:UIColor, textAlignment:NSTextAlignment ) -> UILabel {
        let label:UILabel = zz_label(text: text, textColor: textColor, font: font, textAlignment:textAlignment)
        label.backgroundColor = backgroundColor
        return label
    }
    
    
    
    ///  ------------  实例方法 -------------
    
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont, _ textAlignment:NSTextAlignment, _ numberOfLines:NSInteger) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    func zz_label( _ textColor:UIColor, _ font:UIFont, _ numberOfLines:NSInteger) {
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont) {
        zz_label(text, textColor, font, .left, 1)
    }
    
    /**  label 设置对齐方式 **/
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont, _ textAlignment:NSTextAlignment) {
        zz_label(text, textColor, font,  textAlignment, 1)
    }
    
    /** label 设置行数 **/
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont, _ numberOfLines:NSInteger) {
        zz_label(text, textColor, font,  .left, numberOfLines)
    }
    
    /** label 设置背景色 **/
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont, _ backgroundColor:UIColor) {
        zz_label(text, textColor, font,  .left, 1)
        self.backgroundColor = backgroundColor
    }
    
    /** label 设置对齐方式 背景色 **/
    func zz_label(_ text:String, _ textColor:UIColor, _ font:UIFont, _ backgroundColor:UIColor, textAlignment:NSTextAlignment )  {
        zz_label(text, textColor, font,  textAlignment, 1)
        self.backgroundColor = backgroundColor
    }
    
    /** label 切圆角 **/
    func zz_labelCornerRadius( _ cornerRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius =  cornerRadius
    }
}

