# ZZBaseKit

[![CI Status](https://img.shields.io/travis/185226139@qq.com/ZZBaseKit.svg?style=flat)](https://travis-ci.org/185226139@qq.com/ZZBaseKit)
[![Version](https://img.shields.io/cocoapods/v/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)
[![License](https://img.shields.io/cocoapods/l/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)
[![Platform](https://img.shields.io/cocoapods/p/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
  导入项目中

    `pod  ZZBaseKit` 导入整个库
    
    也可导入部分到库，里面的每个文件夹都可单独导入，如：
    
    `pod ZZBaseKit/Defines` 导入库里面的Defines常用的方法定义
    `pod ZZBaseKit/CryptManager` 导入库里面的CryptManager加解密
    `pod ZZBaseKit/KeyChain` 导入库里面的KeyChain钥匙串存储
    `pod ZZBaseKit/DeviceInfo` 导入库里面的DeviceInfo设备信息
    `pod ZZBaseKit/Extensions` 导入库里面的Extensions常用类的Extension
    `......`

## Version new features

v0.1.3   
       
ZZAlertSystemView  封装了系统弹窗   
        
    ``` 
    例如：显示一个弹窗
    ZZAlertSystemView.zz_alertSystem(nil, "这是一个提示")
    ```
    
ZZCurrentVC   封装了获取当前控制器的方法 

    ``` 
    例如： 获取当前控制器
    zz_currentVC()
    zz_currentVCFromeView(view)
           
    ```
     
     
v 0.1.4 

ZZDeviceInfo 获取设备信息
      
    ``` 
    例如：获取运营商名称   
    ZZDeviceInfo.zz_getDeviceSupplier() 
      
    ```
     
ZZAttributedStr 设置字符串的样式
      
    ```
    例如：设置字符串的行高   
    ZZAttributedStr.zz_setLineHeight("这是一个测试数据", 8, .center)

    ```
v 0.1.6 

增加 ZZWKWebVC 、ZZShowError

    ```
    let webVc = ZZWKWebController()

    webVc.url = "https://www.baidu.com"
    webVc.loadType = .rules 
    
    ///.interaction 需要实现下面的方法

    webVc.zz_wkWebLoadCompletionHandler(block: {
        (count, url) in
        print("\(count) --- \( url)")
        })
    webVc.zz_wkWebSetParams(phone: "13233258888", aesPhone: "X/A+jXMnFGS81LZjC7XTmw==",userLoginId: "12233", umDeviceToken: "sdcdfvfgbvghfbdsvdfgdrbvsdfvtgbdfgbvfg")
        
    self.navigationController?.pushViewController(webVc, animated: true)

    ```
v 0.1.7

1.增加 KeyChain 保存数据到钥匙串 
2. 修复webView链接的处理 
3. 适配系数修改
   

    ```
    //使用介绍
    ///保存
    let result =  ZZKeyChain.zz_keyChainSaveDta(account: "Passer", password: "Montanus", data: ["idfa": ZZ_APP_IDFA])
    ///获取
    let searchData = ZZKeyChain.zz_keyChainReadData(account: "Passer", password: "Montanus")
    ///修改
    ZZKeyChain.zz_keyChainUpdateData(account: "Passer", password: "Montanus", data: searnewDic)
    ///删除
    ZZKeyChain.zz_keychainDelete(account: "Passer", password: "Montanus")
    
    ```
    

   v 0.1.8 增加加密库 CryptManager ,修复webView的部分bug
    
    ```
    //使用方法
    AES 加解密
    ZZCryptManager.zz_aesEncrypt(_ text: String, _ key:[UInt8], _ iv:[UInt8])
    ZZCryptManager.zz_aesEncryptStr(_ text: String, _ key:String, _ iv:String)
    zz_aesDecrypt(_ aesText: String, _ key:[UInt8], _ iv:[UInt8])
    zz_aesDecryptStr(_ aesText: String, _ key:String, _ iv:String)
    MD5加密
    zz_md5Encrypt(_ text: String )
    RSA加解密
    ZZCryptManager.zz_rsaEncrypt(_ text: String, _ publicKey: String)
    ZZCryptManager.zz_rsaDecrypt(_ encryptData: String, _ privateKey: String)
    ZZCryptManager.zz_rsaDecryptPublic(_ encryptData: String, _ publicKey: String)
    加签
    ZZCryptManager.zz_rsaSignWithSHA1(_ text: String, _ privateKey: String) 
    RSA验签
    ZZCryptManager.zz_rsaSignVerifyWithSHA1(_ originalStr: String, _ siginStr: String, _ publicKey: String)
    ```

## Installation

ZZBaseKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZZBaseKit'
```

## Author

liguoliang

## License

ZZBaseKit is available under the MIT license. See the LICENSE file for more info.
