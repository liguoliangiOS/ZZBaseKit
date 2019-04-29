//
//  ZZAttributedStr.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/23.
//

import UIKit

open class ZZAttributedStr: NSObject {
    
    ///修改指定文字的字体大小 和 颜色
   public class func zz_setRangeText(_ text: String, _ changeText: String, _ changeColor: UIColor, _ changeFont: UIFont) -> NSAttributedString  {
        let attributStr = NSMutableAttributedString(string: text)
        let textStr = text as NSString
        let range = textStr.range(of: changeText)
        attributStr.addAttribute(NSAttributedString.Key.font, value: changeFont, range: range)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor, range: range)
        return attributStr
    }
    
    ///设置行间距
   public class func zz_setLineHeight(_ text: String, _ lineHeight: CGFloat, _ alignment:   NSTextAlignment) -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.alignment = alignment;//文本对齐方式
        attributStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        return attributStr
    }
    
    ///设置指定范围内文字的颜色
   public class func zz_setRangeTextColor(_ text: String, range: NSRange, changeColor: UIColor) -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: text)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor, range: range)
        return attributStr
    }
    
    
    ///设置指定范围内文字的下划线 颜色
   public class func zz_setRangeUnderLine(_ text: String, _ range: NSRange, _ rangeColor: UIColor, _ lineColor:UIColor)  -> NSAttributedString {
        let attributStr = NSMutableAttributedString(string: text)
        attributStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributStr.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeColor, range: range)
        attributStr.addAttribute(NSAttributedString.Key.underlineColor, value: lineColor, range: range)
        return attributStr
    }
}
