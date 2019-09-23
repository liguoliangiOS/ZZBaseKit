//
//  QRCodeImage.swift
//  ZZbaseKitTestDemo
//
//  Created by Passer on 2019/5/28.
//  Copyright © 2019 ZZbaseKitTestDemo. All rights reserved.
//

import UIKit
import CoreImage


///生成二维码
class QRCodeImage: NSObject {
    
    ///传入二维码的内容
    class func qr_generateQR(content: String) -> CIImage? {
        if content.count > 0 {
            let filter = CIFilter.init(name: "CIQRCodeGenerator")
            filter?.setDefaults()
            let imageData = content.data(using: .utf8, allowLossyConversion: true)
            filter?.setValue(imageData, forKey: "inputMessage")
            return filter?.outputImage
        }
       return nil
    }
    
    
    ///给图片添加icon，并传入图片的宽高
    class func qr_getImageWithIcon(_ qrImage: UIImage, _ iconImage:UIImage, _ iconWidth: CGFloat, _ iconHeight: CGFloat) -> UIImage{
        UIGraphicsBeginImageContext(qrImage.size)
        qrImage.draw(in: CGRect(origin: CGPoint.zero, size: qrImage.size))
        let x = (qrImage.size.width - iconWidth) * 0.5
        let y = (qrImage.size.height - iconHeight) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: iconWidth, height: iconHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
    ///生成指定尺寸的高清图片
   class func qr_getHDImage(_ ciImage: CIImage, _ size: CGFloat) -> UIImage {
        let integral: CGRect = ciImage.extent.integral
        let proportion: CGFloat = min(size / integral.width, size / integral.height)
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(ciImage, from: integral)!
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    ///给图片生成边框
    class func qr_circleImage(_ sourceImage: UIImage, size:CGFloat, radius:CGFloat, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let scale = sourceImage.size.width / size ;
        //初始值
        let defaultBorderWidth : CGFloat = borderWidth * scale
        let defaultBorderColor = borderColor
        let radius = radius * scale
        let react = CGRect(x: defaultBorderWidth, y: defaultBorderWidth, width: sourceImage.size.width - 2 * defaultBorderWidth, height: sourceImage.size.height - 2 * defaultBorderWidth)
        //绘制图片设置
        UIGraphicsBeginImageContextWithOptions(sourceImage.size, false, UIScreen.main.scale)
        
        let path = UIBezierPath(roundedRect:react , cornerRadius: radius)
        
        //绘制边框
        path.lineWidth = defaultBorderWidth
        defaultBorderColor.setStroke()
        path.stroke()
        
        path.addClip()
        
        //画图片
        sourceImage.draw(in: react)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!;
    }
}
