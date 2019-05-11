//
//  ZZKeyChain.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/5/7.
//

import UIKit
import AdSupport

public class ZZKeyChain: NSObject {
    
    ///保存数据
   public class func zz_keyChainSaveDta(account: String, password:String, data: Any) -> Bool {
        var keychainQuaryDic = zz_keyChainCreateQuaryDic(account,password)
        SecItemDelete(keychainQuaryDic as CFDictionary)
        keychainQuaryDic.updateValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        let saveState = SecItemAdd(keychainQuaryDic as CFDictionary, nil)
        if saveState == noErr  {
            return true
        }
        return false
    }
    
    ///更新数据
   public class func zz_keyChainUpdateData(account: String, password:String, data: Any) -> Bool {
        let keychainQuaryDic = zz_keyChainCreateQuaryDic(account,password)
        var updataKeyChainDic = [String: Any].init(minimumCapacity: 0)
        updataKeyChainDic.updateValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        let updataStatus = SecItemUpdate(keychainQuaryDic as CFDictionary, updataKeyChainDic as CFDictionary)
        if updataStatus == noErr {
            return true
        }
        return false
    }
    
    ///读取数据
   public class func zz_keyChainReadData(account: String, password:String) -> Any {
        var idObject:Any?
        var keyChainReadDic = zz_keyChainCreateQuaryDic(account,password)
        keyChainReadDic.updateValue(kCFBooleanTrue as Any, forKey: kSecReturnData as String)
        keyChainReadDic.updateValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        var queryResult: AnyObject?
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadDic as CFDictionary, UnsafeMutablePointer($0))}
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
            }
        }
        return idObject as Any
    }
    
    ///删除数据
   public class func zz_keychainDelete(account: String, password:String) -> Void {
        let keyChainReadDic = zz_keyChainCreateQuaryDic(account,password)
        SecItemDelete(keyChainReadDic as CFDictionary)
    }
    
    /// 创建查询条件
    private class func zz_keyChainCreateQuaryDic(_ account: String, _ password:String) -> [String: Any] {
        var keychainQuaryDic = [String: Any].init(minimumCapacity: 0)
        keychainQuaryDic.updateValue(kSecClassGenericPassword, forKey: kSecClass as String)
        keychainQuaryDic.updateValue(password, forKey: kSecAttrService as String)
        keychainQuaryDic.updateValue(account, forKey: kSecAttrAccount as String)
        keychainQuaryDic.updateValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        return keychainQuaryDic
    }
    
    public class func zz_keyChainIdfa() -> String {
       
        let identifier = Bundle.main.bundleIdentifier!
        let keychainStr = "zz.keyChain.private.\(identifier).idfa"
        if let result = ZZKeyChain.zz_keyChainReadData(account: keychainStr, password: keychainStr) as? String {
            return result
        } else {
            var dataStr: String?
            if #available(iOS 10.0, *)  {
                if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                    dataStr = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                } else {
                    dataStr = UIDevice.current.identifierForVendor!.uuidString
                }
            } else {
                dataStr = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            }
            _ = ZZKeyChain.zz_keyChainSaveDta(account: keychainStr, password: keychainStr, data: dataStr as Any)
            return dataStr!
        }
    }
}
