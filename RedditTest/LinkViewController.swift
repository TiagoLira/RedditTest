//
//  LinkViewController.swift
//  RedditTest
//
//  Created by Tiago Lira on 16/03/2018.
//  Copyright © 2018 Tiago Lira. All rights reserved.
//

import UIKit
import reddift
import WebKit

class LinkViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var link : Link?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.navigationItem.title = link?.title

        if let urlString = link?.url,
            let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }

}
