//
//  webkitViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit
import WebKit

class webkitViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    @IBOutlet var navBar : UINavigationBar!
    

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.backgroundColor = .black
        navBar!.setBackgroundImage(UIImage(), for: .default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
        navBar!.backgroundColor = .clear
        
        let urlAddress = URL(string: "https://www.apple.com/ca/")
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self

        
        

    }
    


}
