//
//  RedditWebViewController.swift
//  reddit-viewer
//
//  Created by Steven Luplow on 2/21/19.
//  Copyright © 2019 Steven Luplow. All rights reserved.
//

import UIKit
import WebKit

class RedditWebViewController: UIViewController {
    
    var targetUrl : String!

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.load(URLRequest.init(url: URL.init(string: targetUrl)!))
    }
}
