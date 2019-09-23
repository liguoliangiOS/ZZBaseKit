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
        
        let phoneFiled = ZZTextField.zz_initTextField(fieldType: .IDCAR, limitCount: 18, delegate: self)
        phoneFiled.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        phoneFiled.backgroundColor = .orange
        self.view.addSubview(phoneFiled)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension TestViewController: ZZTextFieldDelegate {
    
    func zz_textFiledEndEditing(textField: ZZTextField) {
        
        print(textField.text)
    }
    
}
