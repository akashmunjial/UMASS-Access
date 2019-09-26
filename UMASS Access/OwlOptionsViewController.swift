//
//  OwlOptionsViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 7/9/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

class OwlOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    let owlOptions = UserDefaults.standard.object(forKey: "OwlOptions") as! [String : String]
    var keys : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Do any additional setup after loading the view.
        self.addNavBar()
        self.addTableView()
        keys = Array(self.owlOptions.keys)
        keys.sort()
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width, height: 44))
        let navItem = UINavigationItem(title: "OWL Section")
        let exitButton = UIBarButtonItem(title: "Exit", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(exit))
        navItem.rightBarButtonItem = exitButton
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
        tableView.isScrollEnabled = true
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return owlOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = keys[indexPath.row]
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        let key = cell.textLabel?.text
        let url = owlOptions[key!]
        UserDefaults.standard.set(url, forKey: "OwlLink")
        let destVC = CredentialsViewController()
        destVC.url = url!
        destVC.key = "Owl"
        self.present(destVC, animated: true, completion: nil)
    }
    
    @objc func exit() {
        let destVC = ViewController()
        self.present(destVC, animated: true, completion: nil)
    }
}
