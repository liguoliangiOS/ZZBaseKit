//
//  ZZAlertSystemView.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/18.
//

import UIKit

public typealias ZZAlertSystemSelectBlock = (_ selectIndex: Int) -> Void

///系统的alertView
public class ZZAlertSystemView: UIView {
    
    ///没有按钮
   public class func zz_alertSystem(_ title: String? , _ message: String) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        zz_alertCurrentVC()?.present(alertVc, animated: true, completion: nil)
        zz_dissMissAlert(alertVc, 1.0)
    }
    
    ///没有按钮 可以设置提示时间
   public class func zz_alertSystem(_ title: String? , _ message: String, _ showTime: TimeInterval) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        zz_alertCurrentVC()?.present(alertVc, animated: true, completion: nil)
        zz_dissMissAlert(alertVc, showTime)
    }
    
    ///单个按钮点击没有回调
   public class func zz_alertSystem(_ title: String? , _ message: String, _ buttonTitle: String) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {
            (UIAlertAction) -> Void in
            
        })
        alertVc.addAction(action)
        zz_alertCurrentVC()?.present(alertVc, animated: true, completion: nil)
    }
    
    ///单个按钮点击有回调
   public class func zz_alertSystem(_ title: String? , _ message: String, _ buttonTitle: String, selectIndex:@escaping ZZAlertSystemSelectBlock) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {
            (UIAlertAction) -> Void in
            selectIndex(0)
        })
        alertVc.addAction(action)
        zz_alertCurrentVC()?.present(alertVc, animated: true, completion: nil)
    }
    
    ///两个按钮点击有回调
   public class func zz_alertSystem(_ title: String? , _ message: String, _ cancelTitle: String, _ okTitle: String, selectIndex:@escaping ZZAlertSystemSelectBlock) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: {
            (UIAlertAction) -> Void in
            selectIndex(0)
        })
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: {
            (UIAlertAction) -> Void in
            selectIndex(1)
        })
        alertVc.addAction(cancelAction)
        alertVc.addAction(okAction)
        zz_alertCurrentVC()?.present(alertVc, animated: true, completion: nil)
    }
}

///private
extension ZZAlertSystemView {
    
    private class func zz_dissMissAlert(_ alertVC: UIAlertController, _ showTime: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + showTime, execute: {
            alertVC.dismiss(animated: true, completion: nil)
        })
    }
    
    /// 根据根控制器，返回当前控制器
    private class func zz_alertCurrentVC() -> UIViewController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return zz_alertMapGetCurrentVC(rootVC: rootVC)
    }
    
    
    
    /// 递归找最上面的控制器
    private class func zz_alertMapGetCurrentVC(rootVC :UIViewController) -> UIViewController? {
        var currentVC: UIViewController?
        if rootVC.presentedViewController != nil {
            currentVC = rootVC.presentedViewController
        } else if rootVC.isKind(of: UITabBarController.self) == true {
            currentVC =  zz_alertMapGetCurrentVC(rootVC: (rootVC as! UITabBarController).selectedViewController!)
        } else if rootVC.isKind(of: UINavigationController.self) == true {
            currentVC = zz_alertMapGetCurrentVC(rootVC: (rootVC as! UINavigationController).visibleViewController!)
        } else {
            currentVC = rootVC
        }
        return currentVC
    }
}

