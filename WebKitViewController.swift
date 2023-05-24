//
//  WebKitViewController.swift
//  News
//
//  Created by Лев Ивлев on 27.04.2023.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    var urlSite = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: urlSite)!))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        if webView.url?.absoluteString != urlSite{
            webView.load(URLRequest(url: URL(string: urlSite)!))
        }
    }
    
}
