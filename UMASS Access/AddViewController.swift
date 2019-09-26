//
//  AddViewController.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/20/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let availableOptions: [String] = ["Moodle", "Spire", "Gradescope", "Owl", "Blackboard"]
    var chosenOptions: [String] = []    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        if UserDefaults.standard.object(forKey: "ChosenOptions") != nil {
            chosenOptions = UserDefaults.standard.object(forKey: "ChosenOptions") as! [String]
        }
        // Do any additional setup after loading the view.
        self.addNavBar()
        self.addTableView()
    }
    
    func addNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width, height: 44))
        let navItem = UINavigationItem(title: "Add")
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(back))
        navItem.leftBarButtonItem = backButton
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
        return availableOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(availableOptions[indexPath.row])"
        cell.textLabel!.textAlignment = .center
        if chosenOptions.contains("\(availableOptions[indexPath.row])") {
            cell.backgroundColor = UIColor.gray
        }
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if chosenOptions.contains("\(availableOptions[indexPath.row])") {
            let ind = chosenOptions.firstIndex(of: "\(availableOptions[indexPath.row])")
            chosenOptions.remove(at: ind!)
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
        }
        else {
            chosenOptions.append("\(availableOptions[indexPath.row])")
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.gray
        }
    }
    
    @objc func back() {
        UserDefaults.standard.set(chosenOptions, forKey: "ChosenOptions")
        let destVC = ViewController()
        self.present(destVC, animated: true, completion: nil)
    }
}
