//
//  ZZConstantDefine.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit
import AdSupport


// MARK: ------------------------- 常用的值 --------------
/** 屏幕宽度 **/

public var ZZ_SCREEN_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
}

/** 屏幕高度 **/
public var ZZ_SCREEN_HEIGHT: CGFloat {
    return UIScreen.main.bounds.height
}

/** 整个屏幕 **/
public var ZZ_SCREEN_FULL:CGRect {
    return UIScreen.main.bounds
}

/** 屏幕倍数 **/
public var ZZ_SCREEN_SCALE: CGFloat {
    return UIScreen.main.scale
}

/** 屏幕宽度比例系数 **/
public var ZZ_WIDTH_SCALE_FACTOR:CGFloat {
    return ZZ_SCREEN_WIDTH / 375
}

/** 屏幕高度比例系数 **/
public var ZZ_HEIGHT_SCALE_FACTOR: CGFloat {
    return zz_isIphonexType() ? (zz_isIphoneXR() ? 1.03 : 1.01) : (ZZ_SCREEN_HEIGHT / 667)
}

/** 导航栏高度 **/
public var ZZ_NAVIGATION_HEIGHT:CGFloat {
    return zz_isIphonexType() ? 88 : 64
}

/** Tabbar的高度 **/
public var ZZ_TABBAR_HEIGHT:CGFloat {
    return zz_isIphonexType()  ? 83 : 49
}

/** 安全域的高度 ipnoneX 有值 **/
public var ZZ_BOTTOMBAR_HEIGHT:CGFloat {
    return zz_isIphonexType() ? 34.0 : 0
}

/** 状态栏的高度 ipnoneX 有值 **/
public var ZZ_STATUSBAR_HEIGHT:CGFloat {
    return zz_isIphonexType() ? 44.0 : 20
}


// MARK: --------------------------- 设备系统信息 ---------------------

/** App 名称 **/
public var ZZ_APP_NAME:String  {
    return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
}

/** AppBundle Identifier **/
public var ZZ_APP_BUNDLE_ID:String  {
    return Bundle.main.bundleIdentifier!
}

/** App 版本号 **/
public var ZZ_APP_VERSION:String  {
    return Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
}

/** App ios 版本号 **/
public var ZZ_APP_SYSTEM_VERSION:String {
    return UIDevice.current.systemVersion
}

/** App idfa 版本号 **/
public var ZZ_APP_IDFA: String {
    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
}

/** BundleName   **/
public var ZZ_APP_BUNDLE_NAME: String {
    return Bundle.main.infoDictionary!["CFBundleName"] as! String
}


