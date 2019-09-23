//
//  ZZTextField.swift
//  ZZBaseKit_Example
//
//  Created by Passer on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

@objc public protocol ZZTextFieldDelegate: class {
    //结束编辑
    func zz_textFiledEndEditing(textField: ZZTextField)
    
    //点击键盘删除按钮的出发回调
    @objc optional func zz_deleteBackward()
}

public class ZZTextField: UITextField {
    
    public enum ZZ_FIELD_TYPE {
        ///手机号
        case PHONE
        /// 验证
        case CODE
        /// 密码
        case PASSWORD
        /// 验证密码
        case VERIFY_PASSWORD
        /// 邮箱
        case EMAIL
        ///姓名
        case NAME
        ///身份证
        case IDCAR
        ///限制只能输入数字、字母、中文（如：地址, 公司名称 ）
        case OUT_SPECIAL
    }

    
    private var fieldType:ZZ_FIELD_TYPE?
    private var limit: Int = 0
    public weak var zz_delegate: ZZTextFieldDelegate?
    
    public class func zz_initTextField(fieldType: ZZ_FIELD_TYPE, limitCount: Int, delegate: ZZTextFieldDelegate) -> ZZTextField {
        let feild = ZZTextField.init(frame: CGRect.zero, fieldType: fieldType, limitCount: limitCount)
        feild.zz_delegate = delegate
        return feild
    }
    
    public convenience init(frame: CGRect, fieldType:ZZ_FIELD_TYPE, limitCount: Int) {
        self.init(frame:frame)
        self.limit = limitCount
        self.fieldType = fieldType
        self.delegate = self
        zz_configCustomFeild(fieldType)
    }
    
    private override init(frame: CGRect) { super.init(frame: frame)}
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}


extension ZZTextField: UITextFieldDelegate {
    
    private func zz_configCustomFeild(_ fieldType:ZZ_FIELD_TYPE) {
        ///设置键盘的属性
        if self.fieldType == .PHONE || self.fieldType == .CODE {
            self.keyboardType = .numberPad
        } else {
            self.keyboardType = .default
        }
    }
    
    @objc public func textFieldDidEndEditing(_ textField: UITextField) {
        self.zz_delegate?.zz_textFiledEndEditing(textField: self)
    }
    
    override public func deleteBackward() {
        super.deleteBackward()
        self.zz_delegate?.zz_deleteBackward?()
    }
    
    
    @objc public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let tempText: NSString = textField.text! as NSString
        let str = tempText.replacingCharacters(in: range, with: string)
        
        switch fieldType {
            case .PHONE?, .CODE? : //手机号和验证码都是只能输入数字
                if string.zz_isInputNumber {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            case .PASSWORD?, .VERIFY_PASSWORD?:
                if string.zz_isInputPassText {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            case .EMAIL?:
                if string.zz_isInputEmail {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            case .NAME?:
                if string.zz_isInputNameOutLimit(self.limit) {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            
            case .IDCAR?:
                if string.zz_isInputIdCarNumber {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            
            case .OUT_SPECIAL?:
                if string.zz_isInputOutSpecialLimit(self.limit) {
                    return (str.count > self.limit) ? false : true
                } else {
                    return false
                }
            default:
                return true
        }
    }
}

