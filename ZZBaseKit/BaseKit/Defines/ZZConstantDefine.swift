//
//  ZZConstantDefine.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/13.
//  Copyright © 2019 ZZBaseKit. All rights reserved.
//

import UIKit
import AdSupport

public extension NSObject {
    // MARK: ------------------------- 常用的值 --------------
    /** 屏幕宽度 **/
    var ZZ_SCREEN_WIDTH: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /** 屏幕高度 **/
    var ZZ_SCREEN_HEIGHT: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /** 整个屏幕 **/
    var ZZ_SCREEN_FULL:CGRect {
        return UIScreen.main.bounds
    }
    
    /** 屏幕倍数 **/
    var ZZ_SCREEN_SCALE: CGFloat {
        return UIScreen.main.scale
    }
    
    /** 屏幕宽度比例系数 **/
    var ZZ_WIDTH_SCALE_FACTOR:CGFloat {
        return ZZ_SCREEN_WIDTH / 375
    }
    
    /** 屏幕高度比例系数 **/
    var ZZ_HEIGHT_SCALE_FACTOR: CGFloat {
        return zz_isIphonexType() ? (zz_isIphoneXR() ? 1.1 : 1.02) : (ZZ_SCREEN_HEIGHT / 667)
    }
    
    /** 导航栏高度 **/
    var ZZ_NAVIGATION_HEIGHT:CGFloat {
        return zz_isIphonexType() ? 88 : 64
    }
    
    /** Tabbar的高度 **/
    var ZZ_TABBAR_HEIGHT:CGFloat {
        return zz_isIphonexType()  ? 83 : 49
    }
    
    /** 安全域的高度 ipnoneX 有值 **/
    var ZZ_BOTTOMBAR_HEIGHT:CGFloat {
        return zz_isIphonexType() ? 34.0 : 0
    }
    
    
    // MARK: --------------------------- 设备系统信息 ---------------------
    
    /** App 名称 **/
    var ZZ_APP_NAME:String  {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /** AppBundle Identifier **/
    var ZZ_APP_BUNDLE_ID:String  {
        return Bundle.main.bundleIdentifier!
    }
    
    /** App 版本号 **/
    var ZZ_APP_VERSION:String  {
        return Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
    }
    
    /** App ios 版本号 **/
    var ZZ_APP_SYSTEM_VERSION:String {
        return UIDevice.current.systemVersion
    }
    
    /** App idfa 版本号 **/
    var ZZ_APP_IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    /** BundleName   **/
    var ZZ_APP_BUNDLE_NAME: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }

}


