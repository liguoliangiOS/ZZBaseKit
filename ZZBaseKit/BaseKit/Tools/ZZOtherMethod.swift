//
//  ZZOtherMethod.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

public extension NSObject {
    // MARK: -------------------------- 获取图片的高度 --------------------------
    
    func zz_scaleImageHeight(_ width:CGFloat, _ height:CGFloat, _ realWidth:CGFloat) -> CGFloat {
        let imageH:CGFloat = height / ZZ_SCREEN_SCALE;
        let imageW:CGFloat =  width / ZZ_SCREEN_SCALE;
        let realImageH:CGFloat = imageH * (realWidth / imageW)
        let realH:CGFloat = zz_isIphonexType() ?  24 : 0
        return realH + realImageH;
    }
    
    // MARK: -------------------------- 字符串处理 --------------------------
    
    ///获取某一段文字的CGSize
    func zz_textSize(_ text: String, _ font: UIFont, _ maxWidth: CGFloat) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        let showText = text as NSString
        let textRect:CGRect = showText.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options:[.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attrs, context: nil)
        return textRect.size
    }
    
    ///金额字符串加逗号
    func zz_amoutValue(_ amount:String) -> String {
        var newAmount:String = amount
        if amount.contains(",") {
            newAmount = amount.replacingOccurrences(of: ",", with: "")
        }
        let amountV:Float = Float(newAmount) ?? 0.0
        if amountV == 0 {
            return "0.00";
        }
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let jine:Float = Float(newAmount)!
        let mount:String = format.string(from: NSNumber(value:jine))!
        return mount
    }
    
    ///文字用*号替换处理
    func zz_replaceAsterisk(_ repalceText: String, _ location: Int, _ length: Int) -> String {
        var reultStr = NSString(string: repalceText)
        var satrtLoctaion = location
        for _ in 0 ..< length {
            let range = NSRange(location: satrtLoctaion, length: 1)
            reultStr = reultStr.replacingCharacters(in: range, with: "*") as NSString
            satrtLoctaion = satrtLoctaion + 1
        }
        return reultStr as String
    }
    
    
    // MARK: -------------------------- OpenUrl --------------------------
    
    ///打开链接  OpenUrl
    func zz_openUrl(_ url: URL) -> Bool {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *)  {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return true
        }
        return false
    }
}
