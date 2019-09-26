//
//  WebViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/21/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    typealias credsButton = (user: String, pass: String, button: String)
    let sitewiseCredB: [String : credsButton] = ["Moodle" : ("netid_text", "password_text", "_eventId_proceed"), "Spire" : ("userid", "pwd", "Submit"), "Gradescope" : ("session_email", "session_password", "commit"), "Owl" : ("Login", "Password", "SUBMIT"), "Blackboard" : ("netid_text", "password_text", "_eventId_proceed")]
    var url: String = ""
    var key: String = ""
    var attempt: Bool = true
    var failed: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Do any additional setup after loading the view.
        addNavBar()
        addWebView()
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 25))
        let homeButton = UIBarButtonItem(title: "Home", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(home))
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = homeButton
        navbar.setItems([navItem], animated: false)
        self.view.addSubview(navbar)
    }
    
    func addWebView() {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-25)
        let urlC = URL(string: url)!
        let request = URLRequest(url: urlC)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if attempt {
            if key == "Owl" {
                webView.evaluateJavaScript("document.getElementsByName('\(sitewiseCredB[key]!.user)')[0].value = '\(UserDefaults.standard.object(forKey: key+"Username")!)'")
                webView.evaluateJavaScript("document.getElementsByName('\(sitewiseCredB[key]!.pass)')[0].value = '\(UserDefaults.standard.object(forKey: key+"Password")!)'")
                webView.evaluateJavaScript("document.getElementsByName('\(sitewiseCredB[key]!.button)')[0].click()")
                attempt = false
            }
            else {
                webView.evaluateJavaScript("document.getElementById('\(sitewiseCredB[key]!.user)').value = '\(UserDefaults.standard.object(forKey: key+"Username")!)'")
                webView.evaluateJavaScript("document.getElementById('\(sitewiseCredB[key]!.pass)').value = '\(UserDefaults.standard.object(forKey: key+"Password")!)'")
                webView.evaluateJavaScript("document.getElementsByName('\(sitewiseCredB[key]!.button)')[0].click()")
                attempt = false
            }
        }
        else if failed {
            if key == "Owl" {
                webView.evaluateJavaScript("document.getElementByName('\(sitewiseCredB[key]!.user)')[0].value") { (value, error) in
                    if value == nil {
                        self.failed = false
                    }
                    else {
                        let destVC = CredentialsViewController()
                        UserDefaults.standard.removeObject(forKey: self.key + "Username")
                        UserDefaults.standard.removeObject(forKey: self.key + "Password")
                        destVC.incorrect = true
                        destVC.key = self.key
                        destVC.url = self.url
                        self.present(destVC, animated: true, completion: nil)
                    }
                }
            }
            else {
                webView.evaluateJavaScript("document.getElementById('\(sitewiseCredB[key]!.user)').value") { (value, error) in
                    if value == nil {
                        self.failed = false
                    }
                    else {
                        let destVC = CredentialsViewController()
                        UserDefaults.standard.removeObject(forKey: self.key + "Username")
                        UserDefaults.standard.removeObject(forKey: self.key + "Password")
                        destVC.incorrect = true
                        destVC.key = self.key
                        destVC.url = self.url
                        self.present(destVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func home() {
        let destVC = ViewController()
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains(self.key.lowercased()) {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {})
                }
            }
        }
        self.present(destVC, animated: true, completion: nil)
    }
}
