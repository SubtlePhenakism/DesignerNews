//
//  WebViewController.swift
//  AskArthur
//
//  Created by Robert Passemar on 8/12/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBAction func closeButtonDidTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
    }
    @IBOutlet weak var progressView: UIProgressView!
    var hasFinishedLoading = false
    
    @IBOutlet weak var webView: UIWebView!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let targetURL = NSURL(string: url)
        let request = NSURLRequest(URL: targetURL!)
        webView.loadRequest(request)
        
        webView.delegate = self
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }

}
