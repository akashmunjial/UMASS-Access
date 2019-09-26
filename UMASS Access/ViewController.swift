//
//  ViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/20/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var linkValue: [String : (link: String, image: String)] = ["Moodle": (link: "https://moodle.umass.edu/login", image: "Moodle-logo.svg"), "Spire": (link: "https://www.spire.umass.edu/psp/heproda/?cmd=login&languageCd=ENG&", image: "spire-logo"), "Gradescope": (link: "https://www.gradescope.com/", image: "gradescope-logo"), "Owl": (link: "", image: "owl-logo"), "Blackboard": (link: "https://uma.umassonline.net/webapps/bb-auth-provider-shibboleth-BBLEARN/execute/shibbolethLogin?returnUrl=https%3A%2F%2Fuma.umassonline.net%2Fwebapps%2Fportal%2Fexecute%2FdefaultTab&authProviderId=_9311_1", image: "")]
    var optionsArray: [String] = []
    var key: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Do any additional setup after loading the view.
        if UserDefaults.standard.object(forKey: "ChosenOptions") != nil {
            optionsArray = UserDefaults.standard.object(forKey: "ChosenOptions") as! [String]
        }
        self.addNavBar()
        self.addTableView()
        if UserDefaults.standard.object(forKey: "OwlLink") != nil {
            linkValue["Owl"]?.link = UserDefaults.standard.object(forKey: "OwlLink") as! String
        }
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width, height: 44))
        let navItem = UINavigationItem(title: "Access")
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(logout))
        let addButton = UIBarButtonItem(title: "Add/Remove", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(add))
        navItem.rightBarButtonItem = logoutButton
        navItem.leftBarButtonItem = addButton
        navbar.setItems([navItem], animated: false)
        self.view.addSubview(navbar)
    }
    
    func addTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 76, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 76))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.separatorColor = UIColor.clear
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        let val = linkValue["\(optionsArray[indexPath.row])"]
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.image = UIImage(named: val!.image)
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        key = optionsArray[indexPath.row]
        if checkCredentials() == false
        {
            if key == "Owl" {
                let destVC = OwlOptionsViewController()
                self.present(destVC, animated: true, completion: nil)
            }
            else {
                let destVC = CredentialsViewController()
                destVC.key = key
                destVC.url = linkValue[key]!.link
                self.present(destVC, animated: true, completion: nil)
            }
        }
        else {
            let destVC = WebViewController()
            destVC.url = linkValue[key]!.link
            destVC.key = key
            self.present(destVC, animated: true, completion: nil)
        }
    }
    
    @objc func logout() {
        let destVC = LogoutViewController()
        self.present(destVC, animated: true, completion: nil)
    }
    
    @objc func add() {
        let destVC = AddViewController()
        self.present(destVC, animated: true, completion: nil)
    }
    
    func checkCredentials() -> Bool {
        if UserDefaults.standard.object(forKey: key+"Username") ==  nil {
            return false
        }
        return true
    }
}

