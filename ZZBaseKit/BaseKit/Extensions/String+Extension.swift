//
//  String+Extension.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit


public extension String {
    ///处理 输入表情符号的时候 count 跟 oc里面的字符串length长度不一致的问题
    var length: Int {
        get {
            return self.utf16.count
        }
    }
    
     /////判断手机号是否规范
    var zz_isMobileNumber: Bool {
        if self.count != 11  {
            return false
        }
        return zz_predicate("^1\\d{10}$")
    }
    
    ///判断邮箱的正则
    var zz_isEmial: Bool {
        return zz_predicate("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+(cn|com|net|org|gov|club)$")
    }
    
    ///判断固定电话
    var zz_isTelephone: Bool {
        return zz_predicate("^(0[0-9]{2,3})?([2-9][0-9]{6,7})")
    }
    
    ///判断是纯数字
    var zz_isAllNumber: Bool {
        return zz_predicate("[0-9]*")
    }
    ///判断包含数字、字母、中文字符
    var zz_isOutSpecial: Bool {
        return zz_predicate("[a-zA-Z0-9\\u4E00-\\u9FA5]+")
    }
    
    ///判断不包含emoji
    var zz_isUnContainsEmoji: Bool {
        do {
            let submitText = self.replacingOccurrences(of: " ", with: "")
            let origleLength = submitText.count
            let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]"
            let expression = try NSRegularExpression(pattern:pattern , options: .caseInsensitive)
            let result:String = expression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:  NSMakeRange(0, self.count), withTemplate: "")
            if (origleLength != result.count) {
                return false
            }
            return true
        } catch  {
            return true
        }
    }
    ////判断中文字
    var zz_isChineseName: Bool {
        if self.count < 2 {
            return false
        }
        let rangeO = self.range(of: "·")
        let rangeT = self.range(of: "•")
        if rangeO != nil || rangeT != nil { //中间带有 · •的名字
            return zz_predicate("^[\\u4e00-\\u9fa5]+[·•][\\u4e00-\\u9fa5]+$")
        } else { //一般的名字
            return zz_predicate("^[\\u4e00-\\u9fa5]+$")
        }
    }
    
    var zz_isInputName: Bool {
        if self.count == 0 {
            return true
        }
        let regextestStr: String = "[·•➋➌➍➎➏➐➑➒a-zA-Z0-9\\u4e00-\\u9fa5]{0,30}"
        return zz_predicate(regextestStr)
    }
    
     /////判断只能输入数字
    var zz_isInputNumber: Bool {
        return zz_characterSetWithStr("0123456789\n", self)
    }
    
    /////判断密码能输入的格式
    var zz_isInputPassText: Bool {
        return zz_characterSetWithStr("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", self)
    }
    
    ///判断身份证能输入的格式
    var zz_isInputIdCarNumber:  Bool {
        return zz_characterSetWithStr("0123456789xX", self)
    }
    
    
    ///判断邮箱能输入的格式
    var zz_isInputEmail: Bool {
        return zz_predicate("[a-zA-Z0-9@.]*")
    }
    
    /////自定义位数 正则匹配用户密码字和字母组合
    func zz_password(_ min: Int, _ max: Int) -> Bool {
        if self.count == 0 {
            return false
        }
        return zz_predicate(String(format: "^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{%d,%d}$", min, max))
    }
    ///限制输入姓名格式为 中文数字英文和·•
    func zz_isInputNameOutLimit(_ maxLimit: Int) -> Bool {
        if self.count == 0 {
            return true
        }
        let regextestStr: String = "[·•➋➌➍➎➏➐➑➒a-zA-Z0-9\\u4e00-\\u9fa5]{0,\(maxLimit)}"
        return zz_predicate(regextestStr)
    }
    
    ///限制输入姓名格式为 中文数字英文和·•
    func zz_isInputOutSpecialLimit(_ maxLimit: Int) -> Bool {
        if self.count == 0 {
            return true
        }
        let regextestStr: String = "[➋➌➍➎➏➐➑➒a-zA-Z0-9\\u4e00-\\u9fa5]{0,\(maxLimit)}"
        return zz_predicate(regextestStr)
    }
    
    func zz_characterSetWithStr(_ characterStr: String, _ judgeText: String) -> Bool {
        let characterSet = NSCharacterSet(charactersIn: characterStr).inverted
        let filterArr:[String] = judgeText.components(separatedBy: characterSet)
        let filterstr:String = filterArr.joined(separator: "")
        let result:Bool = judgeText == filterstr
        if result {
            return true
        }
        return false
    }
    
    func zz_predicate(_ pattern: String) -> Bool {
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES%@", pattern)
        return predicate.evaluate(with: self)
    }
}


// MARK: NSAttributedString
public extension String {
    
    ///修改指定文字的字体大小 和 颜色
    func zz_setRangeText(_ changeText: String, _ changeColor: UIColor, _ changeFont: UIFont) -> NSAttributedString  {
        let attributStr = NSMutableAttributedString(string: self)
        let textStr = self as NSString
        let range = textStr.range(of: changeText)
        attributStr.addAttribute(NSAttributedString.Key.font, value: changeFont, range: range)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor, range: range)
        return attributStr
    }
    
    ///设置行间距
    func zz_setLineHeight(_ lineHeight: CGFloat, _ alignment:   NSTextAlignment) -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.alignment = alignment;//文本对齐方式
        attributStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.count))
        return attributStr
    }
    
    ///设置指定范围内文字的颜色
    func zz_setRangeTextColor( range: NSRange, changeColor: UIColor) -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: self)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor, range: range)
        return attributStr
    }
    
    
    ///设置指定范围内文字的下划线 颜色
    func zz_setRangeUnderLine( _ range: NSRange, _ rangeColor: UIColor, _ lineColor:UIColor)  -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: self)
        attributStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeColor, range: range)
        attributStr.addAttribute(NSAttributedString.Key.underlineColor, value: lineColor, range: range)
        return attributStr
    }
}
