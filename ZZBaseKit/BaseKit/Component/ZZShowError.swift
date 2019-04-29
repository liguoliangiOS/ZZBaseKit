//
//  ZZShowError.swift
//  
//
//  Created by Passer on 2019/4/22.
//

import UIKit

public class ZZShowError: UIView {

    convenience init(frame: CGRect, error: String, textFont: UIFont) {
        self.init(frame: frame)
        zz_addErrorSubViews(error, textFont)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension ZZShowError {
    
    class func zz_showError(_ message: String?)  {
        if message != nil {
            DispatchQueue.main.async {
                let erroView = ZZShowError(frame: ZZ_SCREEN_FULL, error: message!, textFont: zz_fontRg(15))
                let window:UIWindow = UIApplication.shared.keyWindow!
                window.addSubview(erroView)
            }
        }
    }
    
    class func zz_showError(_ message: String?, _ textFont: UIFont)  {
        if message != nil {
            DispatchQueue.main.async {
                let erroView = ZZShowError(frame: ZZ_SCREEN_FULL, error: message!, textFont: textFont)
                let window:UIWindow = UIApplication.shared.keyWindow!
                window.addSubview(erroView)
            }
        }
    }
    
    private func zz_addErrorSubViews(_ showText: String, _ textFont: UIFont) {
        
        let marginX:CGFloat = zz_x(20)
        let valibleW:CGFloat = ZZ_SCREEN_WIDTH - marginX * 2
        
        let paddingX:CGFloat = zz_x(30)
        let paddingY:CGFloat = zz_x(20)
        
        let size:CGSize = zz_textSize(showText, textFont, valibleW)
        
        var totalW:CGFloat = size.width + paddingX
        let totalH:CGFloat = size.height + paddingY
        
        if totalW > valibleW {
            totalW = valibleW
        }
        let totalY:CGFloat = (ZZ_SCREEN_HEIGHT / 2 - totalH)
        let totalX:CGFloat = (ZZ_SCREEN_WIDTH - totalW) / 2
        
        let textLabel = UILabel.zz_label(text: showText, textColor: UIColor.white, font: textFont, numberOfLines: 0)
        textLabel.frame = CGRect(x: totalX, y: totalY, width: totalW, height: totalH)
        textLabel.backgroundColor = zz_hexColor("#555555")
        textLabel.textAlignment = .center
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 4
        self.addSubview(textLabel)
        
        zz_hidddenErrorView(textLabel)
    }
    
    private func zz_hidddenErrorView(_ label: UILabel) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            self.removeFromSuperview()
            label.removeFromSuperview()
        })
    }
}

