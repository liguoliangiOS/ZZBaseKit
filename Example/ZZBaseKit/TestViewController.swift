//
//  TestViewController.swift
//  ZZBaseKit_Example
//
//  Created by Passer on 2019/4/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ZZBaseKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ZZAlertSystemView.zz_alertSystem(nil, "这是一个提示")
    }
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
