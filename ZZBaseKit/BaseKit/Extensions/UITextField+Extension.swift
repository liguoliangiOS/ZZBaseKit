//
//  UITextField+Extension.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /** 快速创建 textField **/
    class func zz_textField(textColor: UIColor, font: UIFont, placeholder: String) -> UITextField {
        let textField = self.init()
        textField.textColor = textColor
        textField.font = font
        textField.placeholder = placeholder
        textField.borderStyle = .none;
        return textField
    }
    
    
    /** 快速创建 textField **/
    func zz_textField(_ textColor: UIColor, _ font: UIFont, _ placeholder: String) {
        self.textColor = textColor
        self.font = font
        self.placeholder = placeholder
        self.borderStyle = .none;
    }
    
    /** 设置 placeHolder的字体的颜色 **/
    
    func zz_textFieldPlaceholder(_ color: UIColor, _ font: UIFont) {
        self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
        self.setValue(font, forKeyPath:"_placeholderLabel.font")
    }
    
    
    /** 创建 leftview **/
    func zz_textFieldSetLeftView(_ leftView: UIView?) {
        if leftView != nil  {
            self.leftView = leftView
            self.leftViewMode = .always
        }
    }
    
    /** 创建 rightView **/
    func zz_textFieldSetRightView(_ rightView: UIView?) {
        if rightView != nil  {
            self.rightView = rightView
            self.rightViewMode = .always
        }
    }
    
    /** 创建 修改UITextField的清除按钮 **/
    func zz_textFieldChangeClearButton(_ imageName: String) {
        let cleaButton:UIButton =  self.value(forKey: "_clearButton") as! UIButton
        cleaButton.setImage(UIImage(named: imageName), for: .normal)
        self.clearButtonMode = .whileEditing
    }
}

