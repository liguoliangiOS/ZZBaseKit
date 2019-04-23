# ZZBaseKit

[![CI Status](https://img.shields.io/travis/185226139@qq.com/ZZBaseKit.svg?style=flat)](https://travis-ci.org/185226139@qq.com/ZZBaseKit)
[![Version](https://img.shields.io/cocoapods/v/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)
[![License](https://img.shields.io/cocoapods/l/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)
[![Platform](https://img.shields.io/cocoapods/p/ZZBaseKit.svg?style=flat)](https://cocoapods.org/pods/ZZBaseKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements


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
