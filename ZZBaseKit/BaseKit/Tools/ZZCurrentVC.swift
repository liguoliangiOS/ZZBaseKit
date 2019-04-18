//
//  ZZCurrentVC.swift
//  ZZBaseKit
//
//  Created by Passer on 2019/4/18.
//

import UIKit

// MARK: ------------------------- 获取当前控制器 --------------

///根据view获取控制器
public func zz_currentVCFromeView(_ view: UIView)-> UIViewController? {
    var nextResponder: UIResponder? = view
    repeat {
        nextResponder = nextResponder?.next
        if let viewController = nextResponder as? UIViewController {
            return viewController
        }
    } while nextResponder != nil
    
    return nil
}

/// 根据根控制器，返回当前控制器
public func zz_currentVC() -> UIViewController? {
    let rootVC = UIApplication.shared.keyWindow?.rootViewController
    return zz_mapGetCurrentVC(rootVC: rootVC!)
}



/// 递归找最上面的控制器
private func zz_mapGetCurrentVC(rootVC :UIViewController) -> UIViewController? {
    var currentVC: UIViewController?
    if rootVC.presentedViewController != nil {
        currentVC = rootVC.presentedViewController
    } else if rootVC.isKind(of: UITabBarController.self) == true {
        currentVC =  zz_mapGetCurrentVC(rootVC: (rootVC as! UITabBarController).selectedViewController!)
    } else if rootVC.isKind(of: UINavigationController.self) == true {
        currentVC = zz_mapGetCurrentVC(rootVC: (rootVC as! UINavigationController).visibleViewController!)
    } else {
        currentVC = rootVC
    }
    return currentVC
}

