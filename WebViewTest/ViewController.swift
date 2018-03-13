//
//  ViewController.swift
//  WebViewTest
//
//  Created by Manuel Schulze on 09.02.18.
//  Copyright © 2018 Manuel Schulze. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var testImageView: UIImageView!
    
    @IBAction func loadWebsite(_ sender: Any) {
        loadingView.isHidden = false
        
        NetworkService.shared.getFile(path: "webview.html", completion: {
            NetworkService.shared.getFile(path: "css/style.css", completion: {
                NetworkService.shared.getFile(path: "images/square.jpg", completion: {
                    self.loadingView.isHidden = true
                    self.webView.isHidden = false
                    self.fillInContent()
                })
            })
        })
    }
    
    private func fillInContent() {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentURL.appendingPathComponent("webview.html")
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            if let _ = FileManager.default.contents(atPath: fileUrl.path) {
                let baseUrl = fileUrl.deletingLastPathComponent()
                self.webView.loadFileURL(fileUrl, allowingReadAccessTo: baseUrl)
            }
        }
    }
}

