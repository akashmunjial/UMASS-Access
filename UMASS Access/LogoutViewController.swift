//
//  LogoutViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/20/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let superKeys = ["Moodle", "Spire", "Gradescope", "Owl", "Blackboard"]
    var subKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Do any additional setup after loading the view.
        self.addNavBar()
        self.addTableView()
        self.computeSubKeys()
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width, height: 44))
        let navItem = UINavigationItem(title: "Logout")
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneButton
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

    func computeSubKeys() {
        for key in superKeys {
            if UserDefaults.standard.object(forKey: key + "Username") != nil {
                subKeys.append(key)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = subKeys[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = subKeys[indexPath.row]
        UserDefaults.standard.removeObject(forKey: key + "Username")
        UserDefaults.standard.removeObject(forKey: key + "Password")
        self.subKeys.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @objc func done() {
        let destVC = ViewController()
        self.present(destVC, animated: true, completion: nil)
    }
}
