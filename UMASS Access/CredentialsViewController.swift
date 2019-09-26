//
//  CredentialsViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/20/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

class CredentialsViewController: UIViewController, UITextFieldDelegate {
    
    var key: String = ""
    var url: String = ""
    var usernameTextField : UITextField!
    var passwordTextField : UITextField!
    var incorrect: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Do any additional setup after loading the view.
        self.addNavBar()
        self.addWarning()
        self.addContext()
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width, height: 44))
        let navItem = UINavigationItem(title: "Login")
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(back))
        navItem.leftBarButtonItem = backButton
        navbar.setItems([navItem], animated: false)
        self.view.addSubview(navbar)
    }
    
    func addWarning() {
        if incorrect {
            let alertLabel = UILabel(frame: CGRect(x: 30, y: (UIScreen.main.bounds.height)/2 - 70, width: UIScreen.main.bounds.width - 60, height: 30))
            alertLabel.lineBreakMode = .byWordWrapping
            alertLabel.text = "Incorrect/Insufficient Username or Password"
            alertLabel.textAlignment = .center
            self.view.addSubview(alertLabel)
        }
    }
    
    func addContext() {
        let noticeLabel = UILabel(frame: CGRect(x: 30, y: (UIScreen.main.bounds.height)/2 + 80, width: UIScreen.main.bounds.width - 60, height: 40))
        noticeLabel.lineBreakMode = .byWordWrapping
        noticeLabel.text = "The passwords entered here are securely stored in the device for future use to provide a faster interaction."
        noticeLabel.textAlignment = .center
        
        usernameTextField = UITextField(frame: CGRect(x: 30 , y: (UIScreen.main.bounds.height)/2 - 30, width: UIScreen.main.bounds.width - 60, height: 25))
        passwordTextField = UITextField(frame: CGRect(x: 30 , y: (UIScreen.main.bounds.height)/2 + 5, width: UIScreen.main.bounds.width - 60, height: 25))
        usernameTextField.placeholder = "Username"
        usernameTextField.textAlignment = .left
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.clearsOnBeginEditing = true
        usernameTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearsOnBeginEditing = true
        
        let loginButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2 - 30, y: UIScreen.main.bounds.height/2 + 40, width: 60, height: 30))
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.titleLabel?.textColor = .blue
        loginButton.titleLabel?.textAlignment = .center
        loginButton.backgroundColor = .blue
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(noticeLabel)
        self.view.addSubview(loginButton)
    }
    
    @objc func login() {
        if checkProperEntry() {
            let destVC = WebViewController()
            destVC.url = url
            destVC.key = key
            UserDefaults.standard.set(usernameTextField.text!, forKey: key+"Username")
            UserDefaults.standard.set(passwordTextField.text!, forKey: key+"Password")
            self.present(destVC, animated: true, completion: nil)
        }
        else {
            let alertLabel = UILabel(frame: CGRect(x: 30, y: (UIScreen.main.bounds.height)/2 - 70, width: UIScreen.main.bounds.width - 60, height: 30))
            alertLabel.lineBreakMode = .byWordWrapping
            alertLabel.text = "Incorrect/Insufficient Username or Password"
            alertLabel.textAlignment = .center
            self.view.addSubview(alertLabel)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkProperEntry() -> Bool {
        if usernameTextField.text! == "" || passwordTextField.text! == "" {
            return false
        }
        return true
    }
    
    @objc func back() {
        let destVC = ViewController()
        self.present(destVC, animated: true, completion: nil)
    }
}
