//
//  String+JudgeMent.swift
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
        let mobileStr:String = "^1\\d{10}$"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES%@", mobileStr)
        return predicate.evaluate(with: self)
    }
    
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
    
     /////判断只能输入数字
    var zz_isInputNumber: Bool {
        return zz_characterSetWithStr("0123456789\n", self)
    }
    
    
    /////判断密码能输入的格式
    var zz_isInputPassText: Bool {
        return zz_characterSetWithStr("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", self)
    }
    
    
    /////自定义位数 正则匹配用户密码字和字母组合
    func zz_password(_ min: Int, _ max: Int) -> Bool {
        if self.count == 0 {
            return false
        }
        let regextestStr = String(format: "^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{%d,%d}$", min, max)
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES%@", regextestStr)
        return predicate.evaluate(with: self)
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
    
}
