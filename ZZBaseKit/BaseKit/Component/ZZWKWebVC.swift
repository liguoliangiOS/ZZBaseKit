//
//  ZZWKWebVC.swift
//  ZZbaseKitTestDemo
//
//  Created by Passer on 2019/4/28.
//  Copyright © 2019 ZZbaseKitTestDemo. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore


private struct ScriptMessage {
    static let paramsName = "getIosAppUserInfo";
    static let paramsPhoneEncrypt = "getCommonParamsEncrypt"; //加密的电话号码
    static let paramsPhone = "getCommonParamsApi"; //不加密的电话号码
    static let getUserId = "getUserId"; // 获取userId
    static let sendparamsPhoneEncrypt = "setCommonParamsEncrypt"; //加密的电话号码
    static let sendparamsPhone = "setCommonParamsApi"; //不加密的电话号码
    static let sendUserId = "setUserId"; // 获取userId
    static let openToWX = "cpAndToWechat";//跳转微信
}

public enum ZZLoadType: Int {
    ///加载协议等不需要与H5交互的
    case rules = 0
    
    ///其他需要与H5交互的
    case interaction = 1
}

public typealias ZZWkCompletionHandler = (_ count: Int, _ loadURL: URL) -> Void

open class ZZWKWebVC: UIViewController {
    
    public lazy var url: String? = nil
    public lazy var loadType = ZZLoadType.rules
    
    public var zzCanGoback: Bool  {
        get {
          return self.zzWebView.canGoBack
        }
    }
    
    private lazy var configuration = WKWebViewConfiguration()
    private lazy var phoneNumber: String? = nil
    private lazy var phoneEncrypt: String? = nil
    private lazy var userId: String? = nil
    private lazy var umToken: String? = nil
    private lazy var loadCount: Int = 0
    private var completeBlock: ZZWkCompletionHandler?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.zzWebView)
        self.view.addSubview(self.zzProgress)
        zz_wkLoadWebUrl()
    }
    
    public func zz_wkWebLoadCompletionHandler(block: @escaping ZZWkCompletionHandler) {
        self.completeBlock = block
    }
    
    ///传必须的参数
    public func zz_wkWebSetParams(phone: String, aesPhone: String, userLoginId: String, umDeviceToken: String)  {
        self.phoneNumber = phone
        self.phoneEncrypt = aesPhone
        self.userId = userLoginId
        self.umToken = umDeviceToken
    }
     ///网页返回
    public func zz_wkWebGoback() {
        if self.zzWebView.canGoBack {
            self.zzWebView.goBack()
        }
    }
    
    ///网页重新加载
    public func zz_wkWebReload() {
       zz_wkLoadWebUrl()
    }
     ///网页刷新
    public func zz_wkWebRefreshLoad() {
        self.zzWebView.reload()
    }
    
    lazy var zzWebView: WKWebView = {
        let zzWebView = WKWebView(frame: self.view.bounds, configuration: self.configuration)
        zzWebView.navigationDelegate = self
        zzWebView.backgroundColor = .white
        zzWebView.uiDelegate = self
        zzWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        zzWebView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        return zzWebView
    }()
    
    lazy var zzProgress: UIProgressView = {
        let zzProgress = UIProgressView(frame: CGRect(x: 0, y: ZZ_NAVIGATION_HEIGHT, width: ZZ_SCREEN_WIDTH, height: 2))
        zzProgress.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        return zzProgress
    }()
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.zzProgress.progress = Float(self.zzWebView.estimatedProgress)
            if self.zzProgress.progress == 1 {
                UIView.animate(withDuration: 0.25, delay: 0.3, options: .curveEaseOut, animations: {
                    self.zzProgress.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
                }, completion: {
                    (finished: Bool) in
                    self.zzProgress.isHidden = true
                })
            }
        } else  if keyPath == "title" {
            if (object as! WKWebView) == self.zzWebView {
                self.navigationItem.title = self.zzWebView.title
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        zz_wkRemoveScriptMessage(self.zzWebView.configuration.userContentController)
    }
}


extension ZZWKWebVC: WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {
    
      // MARK: ---- WKScriptMessageHandler
   public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == ScriptMessage.paramsPhoneEncrypt {
            zz_wkSendMessageWithComon(ScriptMessage.sendparamsPhoneEncrypt, apiType: message.body as! String, isEcrypt: true)
        } else if message.name == ScriptMessage.paramsPhone {
            zz_wkSendMessageWithComon(ScriptMessage.sendparamsPhone, apiType: message.body as! String, isEcrypt: false)
        } else if message.name == ScriptMessage.getUserId {
            zz_wkUserIdScriptMessage(ScriptMessage.sendUserId)
        } else if message.name == ScriptMessage.openToWX {
            zz_wkOpenWeixinScriptMessage(message.body as! String)
        }
    }
    
    
    // MARK: ---- WKNavigationDelegate
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.zzProgress.isHidden = false
        self.zzProgress.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        self.view.bringSubviewToFront(self.zzProgress)
    }
    
    ///网络错误
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.zzProgress.isHidden = true
    }
    
    ///网页加载完成
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.zzProgress.isHidden = true
        if self.loadType == .interaction {
            zz_wkAutoInputPhone(phone: self.phoneNumber!)
            zz_wkPublicParamScriptMessage(ScriptMessage.paramsName)
            //加载完成回调
            if self.completeBlock != nil {
                self.completeBlock!(self.loadCount, webView.url!)
                self.loadCount += 1
            }
        }
    }
    
    //加载失败
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.zzProgress.isHidden = false
    }
    
     // 加载不授信的https
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.previousFailureCount == 0 { // 如果没有错误的情况下 创建一个凭证，并使用证书
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential, credential)
            } else { // 验证失败，取消本次验证
                completionHandler(.cancelAuthenticationChallenge, nil);
            }
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil);
        }
    }
    
    // 这个代理可以使得服务器返回200以外的状态码
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let statusResponse:HTTPURLResponse = navigationResponse.response as? HTTPURLResponse {
            if statusResponse.statusCode == 200 {
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)
            }
        } else {
            decisionHandler(.cancel)
        }
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if (webView.url?.absoluteString.hasPrefix("itms-appss://"))! {
            zz_wkOpenurl(webView.url!)
        }
        if (webView.url?.absoluteString.hasPrefix("itms-apps://"))! {
            zz_wkOpenurl(webView.url!)
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        if let url = navigationAction.request.url {
            if url.host == "itunes.apple.com" || url.absoluteString.contains("itms-services://") {
                if zz_openUrl(url) {
                   decisionHandler(.cancel)
                    return
                }
            }
        }
        decisionHandler(.allow);
        return;
    }
    
    // MARK: ---- UIDelegate
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        ZZAlertSystemView.zz_alertSystem(nil, message)
        completionHandler()
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        ZZAlertSystemView.zz_alertSystem(nil, message, "取消", "确定", selectIndex: {
            (selectindex: Int) in
            completionHandler((selectindex == 0) ? false : true)
        })
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertVC = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "完成", style: .cancel, handler: {
            (action: UIAlertAction) in
            let alertStr =  alertVC.textFields![0].text
            completionHandler(alertStr)
        })
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}


extension ZZWKWebVC {
    
    private func zz_wkLoadWebUrl() {
        if self.url != nil {
            var zzUrl = URL(string: self.url!)
            if zzUrl == nil {
                zzUrl =  URL(string: wk_strToUtf8(self.url!))
            }
            self.zzWebView.load(URLRequest(url: zzUrl!))
        }
    }
    
    private func wk_strToUtf8(_ str: String) ->  String {
        if str.count > 0 {
            let stri = str as NSString
            let urlStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, stri as CFString, "!NULL,'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue)
            return urlStr! as String
        }
        return str
    }
    
    
    private func zz_wkAddScriptMessage(_ userContent: WKUserContentController) {
        userContent.add(self, name: ScriptMessage.paramsPhoneEncrypt)
        userContent.add(self, name: ScriptMessage.paramsPhone)
        userContent.add(self, name: ScriptMessage.getUserId)
        userContent.add(self, name: ScriptMessage.openToWX)
    }
    
    private func zz_wkRemoveScriptMessage(_ userContent: WKUserContentController) {
        self.zzWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.zzWebView.removeObserver(self, forKeyPath: "title")
        userContent.removeScriptMessageHandler(forName: ScriptMessage.paramsPhoneEncrypt)
        userContent.removeScriptMessageHandler(forName: ScriptMessage.paramsPhone)
        userContent.removeScriptMessageHandler(forName: ScriptMessage.getUserId)
        userContent.removeScriptMessageHandler(forName: ScriptMessage.openToWX)
    }
    
    private func zz_wkOpenurl(_ url: URL)  {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *)  {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /**  placeholder  的方式判断 **/
    private func zz_wkInputWithPlaceholder(_ phoneStr: String) -> String {
        return NSString(format: "javascript:document.querySelector('input[placeholder*=\"手机号\"]').value = '%@'", phoneStr) as String
    }
    
    /**  type tel 的方式判断 **/
    private func zz_wkInputWithTypeTel(_ phoneStr: String) -> String {
        return NSString(format: "javascript:document.querySelector('input[type*=\"tel\"]').value = '%@'", phoneStr) as String
    }

    // 传参给js的公共参数 不需要配置
    private func zz_wkConfigPublicParams() -> [String: Any]  {
        var params = [String: Any]()
        params.updateValue(self.phoneEncrypt!, forKey: "phone")
        params.updateValue(self.phoneNumber!, forKey: "userPhone")
        params.updateValue(ZZ_APP_NAME, forKey: "appName")
        params.updateValue(ZZ_APP_IDFA, forKey: "imei")
        params.updateValue(ZZ_APP_IDFA, forKey: "idfa")
        params.updateValue(ZZ_APP_BUNDLE_ID, forKey: "pkgName")
        params.updateValue(ZZ_APP_VERSION, forKey: "version")
        params.updateValue("App Store", forKey: "channel")
        params.updateValue("2", forKey: "osType")
        return params
    }
    
    private func zz_wkConfigComonParams(apiType: String, isEncrypt: Bool) -> [String: Any]  {
        var params = [String: Any]()
        
        if isEncrypt { // 手机号需要加密
           params.updateValue(self.phoneNumber!, forKey: "phone")
        } else {
            params.updateValue(self.phoneEncrypt!, forKey: "phone")
        }
        params.updateValue(ZZ_APP_NAME, forKey: "appName")
        params.updateValue(ZZ_APP_NAME, forKey: "app_name")
        params.updateValue(apiType, forKey: "apiType")

        params.updateValue(ZZ_APP_IDFA, forKey: "imei")
        params.updateValue(ZZ_APP_IDFA, forKey: "idfa")
        params.updateValue(ZZ_APP_BUNDLE_ID, forKey: "pkgName")
        params.updateValue(ZZ_APP_BUNDLE_ID, forKey: "appPkgName")
        if self.umToken != nil {
            params.updateValue(self.umToken! , forKey: "device_token")
            params.updateValue(self.umToken!, forKey: "deviceToken")
        }
        params.updateValue(ZZ_APP_VERSION, forKey: "version")
        params.updateValue(ZZ_APP_VERSION, forKey: "apkVersion")
        params.updateValue("App Store", forKey: "channel")
        params.updateValue("2", forKey: "osType")
        params.updateValue("2", forKey: "os_type")
        params.updateValue(ZZDeviceInfo.zz_getDeviceName(), forKey: "model")
        
        return params
    }
    
    private func zz_wkAutoInputPhone(phone: String) {
        let scriptStr = zz_wkInputWithPlaceholder(phone)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.zzWebView.evaluateJavaScript(scriptStr, completionHandler: {
                (response, error) in
                if error != nil {
                    let scriptTypeStr = self.zz_wkInputWithTypeTel(phone)
                    self.zzWebView.evaluateJavaScript(scriptTypeStr, completionHandler: nil)
                }
            })
        })
    }
    
    private func zz_wkPublicParamScriptMessage(_ meaageName: String) {
        let jsonStr = zz_dicToJsonStr(zz_wkConfigPublicParams())
        zz_wkSendMessage(jsonStr!, meaageName)
    }
    
    private func zz_wkUserIdScriptMessage(_ meaageName: String) {
        zz_wkSendMessage(self.userId!, meaageName)
    }
    
    private func zz_wkOpenWeixinScriptMessage(_ weixinName: String) {
        let url = URL(string: "weixin://\(ZZ_APP_BUNDLE_ID)")
        let pasteboard = UIPasteboard.general
        pasteboard.string = weixinName
        if !zz_openUrl(url!) {
            ZZAlertSystemView.zz_alertSystem("提示", "无法打开微信，请您确保已经安装微信")
        }
    }
    
    
    private func zz_wkSendMessageWithComon( _ messageName: String, apiType: String,  isEcrypt: Bool) {
        let dic = zz_wkConfigComonParams(apiType: apiType, isEncrypt: isEcrypt)
        let jsonStr = zz_dicToJsonStr(dic)
        zz_wkSendMessage(jsonStr!, messageName)
    }
    
    
    
    private func zz_wkSendMessage(_ paramsStr: String, _ messageName: String) {
        let methodStr = paramsStr + "(\(messageName))"
        DispatchQueue.main.async {
            self.zzWebView.evaluateJavaScript(methodStr, completionHandler: nil)
        }
    }
}
