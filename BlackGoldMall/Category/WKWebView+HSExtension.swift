//
//  WKWebView+HSExtension.swift
//  GMG
//
//  Created by 永芯 on 2019/12/27.
//  Copyright © 2019 永芯. All rights reserved.
//

import WebKit

extension WKWebView {
    
    @discardableResult
    func load(_ urlStr: String) -> WKNavigation? {
        if let url = URL(string: urlStr) {
            return self.load(URLRequest(url: url))
        }
        return nil
    }
    
    /// 文本大小自适应
    func textAutoFit() {
        let textJs = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        self.addJs(js: textJs, time: .atDocumentEnd)
    }
    
    /// 图片宽度自适应
    /// - Parameter space: 图片与父视图的左右间距
    func imgAutoFit(space: CGFloat = 10) {
        let imgJs = String(format: "function imgAutoFit() { var imgs = document.getElementsByTagName('img'); for (var i = 0; i < imgs.length; ++i) { var img = imgs[i]; img.style.maxWidth = %f; } }", space)
        self.addJs(js: imgJs, time: .atDocumentEnd)
    }
    
    /// 注入js代码
    ///
    /// - Parameters:
    ///   - js: js代码
    ///   - time: 执行时间
    func addJs(js: String, time: WKUserScriptInjectionTime) {
        let textScript = WKUserScript(source: js, injectionTime: time, forMainFrameOnly: true)
        self.configuration.userContentController.addUserScript(textScript)
    }

}
