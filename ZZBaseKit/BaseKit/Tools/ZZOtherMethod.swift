//
//  ZZOtherMethod.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

public extension NSObject {
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
    
    ///跳转Dic -> JsonStr
    func zz_dicToJsonStr(_ dic: [String: Any]) -> String? {
        do {
            let jsonData = try  JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            let jsonS = String(data: jsonData, encoding: .utf8)
            return jsonS!
        } catch  {
            print(error)
        }
        return nil
    }
    
    ///跳转JsonStr -> Dic
    func zz_jsonStrToDic(_ jsonStr: String) -> [String: Any]? {
        if jsonStr.count > 0 {
            let data = jsonStr.data(using: .utf8)
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                return (json as! [String: Any])
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    ///跳转appStore评分
    func zz_appStoreComment(_ appId: String) {
        let urlStr = "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"
        let openUrl = URL(string: urlStr)!
        if UIApplication.shared.canOpenURL(openUrl) {
            if #available(iOS 10.0, *)  {
                UIApplication.shared.open(openUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(openUrl)
            }
        }
    }
    
    ///打电话
    func zz_telPone(_ phone: String) {
        if phone != "" && phone != " " && phone.count > 1  {
            let telP = phone.replacingOccurrences(of:" ", with: "")
            let phoneStr = "tel://" + telP
            let phoneUrl = URL(string: phoneStr)
            _ = zz_openUrl(phoneUrl!)
        }
    }
    
    func zz_strEncodingToUtf8(_ str: String) ->  String {
        if str.count > 0 {
            let userved = "!NULL,'()*+,-./:;=?@_~%#[]"
            let allowed = NSMutableCharacterSet(charactersIn: userved)
            let urlStr = str.addingPercentEncoding(withAllowedCharacters:allowed as CharacterSet)
            return urlStr!
        }
        return str
    }
}


