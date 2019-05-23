//
//  ZZFuncDefine.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit

// MARK: ------------------------- 判断设备机型 --------------
/// 判断是否是齐刘海的机型
public func zz_isIphonexType() -> Bool {
    return (zz_isIphoneX() || zz_isIphoneXR() || zz_isIphoneXSMAX())
}

/// 判断是否是iPad
public func zz_isIpad() -> Bool {
    let faceIdiom = UIDevice.current.userInterfaceIdiom
    if faceIdiom == .pad {
        return true
    }
    return false
}

/// 判断是否是iPhone X
public func zz_isIphoneX() -> Bool {
    let phoneSize = UIScreen.main.currentMode?.size
    if (phoneSize?.equalTo(CGSize(width: 1125, height: 2436)))!  && !zz_isIpad() {
        return true
    }
    return false
}

/// 判断是否是iPhone Xr
public func zz_isIphoneXR() -> Bool {
    let phoneSize = UIScreen.main.currentMode?.size
    if (phoneSize?.equalTo(CGSize(width: 828, height: 1792)))!  && !zz_isIpad() {
        return true
    }
    return false
}

/// 判断是否是iPhone XSMAX
public func zz_isIphoneXSMAX() -> Bool {
    let phoneSize = UIScreen.main.currentMode?.size
    if (phoneSize?.equalTo(CGSize(width: 1242, height: 2688)))!  && !zz_isIpad() {
        return true
    }
    return false
}

// MARK: ------------------------- 适配系数 --------------


///适配宽度的系数
public func zz_x(_ size:CGFloat) -> CGFloat {
    return (ZZ_WIDTH_SCALE_FACTOR * size)
}

///适配高度的系数
public func zz_y(_ size:CGFloat) -> CGFloat {
    return (ZZ_HEIGHT_SCALE_FACTOR * size)
}


// MARK: ------------------------- 设置常用的字体 --------------

///设置system字体
public func zz_font(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: zz_x(size))
}

///设置Medium字体
public func zz_fontMd(_ size:CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Medium", size: zz_x(size))!
}

///设置Regular字体
public func zz_fontRg(_ size:CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Regular", size: zz_x(size))!
}

///设置金额字体
public func zz_fontDn(_ size:CGFloat) -> UIFont {
    return UIFont(name: "DIN Alternate", size: zz_x(size))!
}

////自己d传入字体的名称
public func zz_fontC(_ fontName: String,  _ size:CGFloat) -> UIFont {
    return UIFont(name: fontName, size: zz_x(size))!
}

////设置Helvetica字体
public func zz_fontHt(_ size:CGFloat) -> UIFont {
    return UIFont(name: "Helvetica", size: zz_x(size))!
}

// MARK: --------------------------  UserDefaults操作 --------------------------

/// 保存值
public func zz_setUserDefaults(_ key: String, _ value: String) {
    UserDefaults.standard.setValue(value, forKey: key)
}

/// 取出值
public func zz_getUserDefaults(_ key: String) -> String? {
    return UserDefaults.standard.string(forKey: key) ?? nil
}

///删除值
 public func zz_removeUserDefaults(_ key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}

// MARK: ------------------------- 颜色方法 --------------

/// 定义16进制值颜色 例如 zz_hexColor("#F64B4B")
 public func zz_hexColor(_ hex: String) -> UIColor {
    var cstr = hex.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
    if(cstr.length < 6){
        return UIColor.clear;
    }
    if(cstr.hasPrefix("0X")){
        cstr = cstr.substring(from: 2) as NSString
    }
    if(cstr.hasPrefix("#")){
        cstr = cstr.substring(from: 1) as NSString
    }
    if(cstr.length != 6){
        return UIColor.clear;
    }
    var range = NSRange.init()
    range.location = 0
    range.length = 2
    //r
    let rStr = cstr.substring(with: range);
    //g
    range.location = 2;
    let gStr = cstr.substring(with: range)
    //b
    range.location = 4;
    let bStr = cstr.substring(with: range)
    var r :UInt32 = 0x0;
    var g :UInt32 = 0x0;
    var b :UInt32 = 0x0;
    Scanner.init(string: rStr).scanHexInt32(&r);
    Scanner.init(string: gStr).scanHexInt32(&g);
    Scanner.init(string: bStr).scanHexInt32(&b);
    return
        UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0);

}

// MARK: -------------------------- 获取图片的高度 --------------------------

public func zz_scaleImageHeight(_ width:CGFloat, _ height:CGFloat, _ realWidth:CGFloat) -> CGFloat {
    let imageH:CGFloat = height / ZZ_SCREEN_SCALE;
    let imageW:CGFloat =  width / ZZ_SCREEN_SCALE;
    let realImageH:CGFloat = imageH * (realWidth / imageW)
    let realH:CGFloat = zz_isIphonexType() ?  24 : 0
    return realH + realImageH;
}
