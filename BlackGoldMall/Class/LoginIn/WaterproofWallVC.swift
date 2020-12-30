//
//  WebViewController.swift
//  HSEther
//
//  Created by 永芯 on 2019/9/18.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

import UIKit
import WebKit
import Moya


//@objcMembers
class WaterproofWallVC: BaseViewController, WKScriptMessageHandler,WKUIDelegate {
    
    
   
    
    var webView : WKWebView!
  
    
    var urlStr:String = "https://www.baidu.com"
    var customTitle = ""
    var returnTextBlock : ((String)->Void)?
   
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let wkConfig = WKWebViewConfiguration.init()
        wkConfig.allowsInlineMediaPlayback = true
     
            wkConfig.userContentController = WKUserContentController.init()
            wkConfig.userContentController.add(self, name: "signal")
         
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight ), configuration: wkConfig)
        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        webView.isHidden = true
        self.view.addSubview(webView)
       
        let req = URLRequest.init(url: URL.init(string: "https://v.vaptcha.com/app/ios.html?vid=5f50a75b6b50b90a08398ecf&scene=0&lang=zh-CN&offline_server=https://www.vaptchadowntime.com/dometime")!)
        webView.load(req)

    }
    
    override func clickLeftItem() {
        
       
       
    }
    
    



    


 
}

extension WaterproofWallVC:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
//        if customTitle.isEmpty {
//            self.navigationItem.title = "加载中..."
//        }
       

    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        
      
       
            self.title = "安全验证"
//            self.webView.isHidden = false
        
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            webView.isHidden = false
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
 
        /// 弹出提示框点击确定返回
//        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
//        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
//            _=self.navigationController?.popViewController(animated: true)
//        }
//        alertView.addAction(okAction)
//        self.present(alertView, animated: true, completion: nil)
        
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       
        if (message.name == "signal") {
            let jsonString = message.body as! String
        
            let dic = self.dataToDictionary(data:jsonString.data(using: .utf8)!) as! Dictionary<String, Any>
            let signal = dic["signal"] as! String
            if signal == "pass" {
                let token = dic["data"] as! String
                returnTextBlock!(token)
            }else if signal == "cancel"{

            }
            else if signal == "error"{

            }
            self.dismiss(animated: true, completion: nil)
        }
//        clickLeftItem()
    }
    
    
    func dataToDictionary(data:Data) ->Dictionary<String, Any>?{

    do{
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let dic = json as! Dictionary<String, Any>
        return dic
    }catch _ {
            print("失败")
    return nil
        }

    }
    
    

}
