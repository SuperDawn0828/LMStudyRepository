//
//  WebViewViewController.swift
//  WKWebViewDemo
//
//  Created by 黎明 on 2017/8/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        
        let url = URL(string: "https://www.baidu.com")
        webView.load(URLRequest(url: url!))
        
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            print("\(result!)")
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
}
